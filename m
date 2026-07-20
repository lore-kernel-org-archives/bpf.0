Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CC38B149
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531763; cv=none; b=uJQ2JKmJnK2LRP2TbZZk3dMvifJ7itdUGeFxVEYTnKiH+Vl3sTiAeP2x+vM31HkKbo4eS6jujVEsPJwpRxTZ1NKwWPbHzg8TWINCmcVqSn+x1PUwRkCTpQUeWOJzS5i1VHp/TCWoxeA2H+65bMQPTaipPmseiK+iQexmwC9TlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531763; c=relaxed/simple;
	bh=k7aFXPDslZabXbSqkInNEGW0loUuMm4Q91Cxy5PCvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db4BiB/YpiBx4rRHSMn8+XHsC5inwJvXC2JdLJz89Hopn+5fM6FuN+gqKmAJU1M7gfIg5noqM/AmheZ+6pc/WyEpQUe+TlIW9HZL6SdbbM2Q0je4eOMFWPjODYmtx97NrJ5g/GsE5QvrV+97g19tpkbZuU2HDpDqPyDTVAM0LHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=asIIPB3O; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="asIIPB3O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784531749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zXRlh5rEhbu0ayFo7nNMEzVJ9+XSBLY99Gqq4O3Js+c=;
	b=asIIPB3O24AZOauOav1xytEfBbrS78O8Ia4uvSjcIPuFzQ/5Roa2jQ+40J0sEJtEhIuiPh
	VxQmVrGl6B87LyyE3YoWTZ+PQc219zvRlzqhmEYynCZVfozdbFWMWqRXsnbJyOl2q6GmYW
	dgZa3J+vEewT+XxBEsEoVAYC446368k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] bpftool: Skip prog/map that disappears while looking it up by name
Date: Mon, 20 Jul 2026 15:15:18 +0800
Message-ID: <20260720071520.396363-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Looking up a prog or map by name walks the whole id space. There is a
window between bpf_prog_get_next_id()/bpf_map_get_next_id() and getting
an fd for that id in which an unrelated object can be freed, and the
lookup then fails with ENOENT and aborts the whole command.

Skip such ids and keep walking, the same way do_show() already does.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/bpf/bpftool/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 8bfcff9e2f63..ef366ccc9650 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -832,6 +832,8 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 
 		fd = bpf_prog_get_fd_by_id(id);
 		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
 			p_err("can't get prog by id (%u): %s",
 			      id, strerror(errno));
 			goto err_close_fds;
@@ -996,6 +998,8 @@ static int map_fd_by_name(char *name, int **fds,
 		opts_ro.open_flags = BPF_F_RDONLY;
 		fd = bpf_map_get_fd_by_id_opts(id, &opts_ro);
 		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
 			p_err("can't get map by id (%u): %s",
 			      id, strerror(errno));
 			goto err_close_fds;
-- 
2.43.0

