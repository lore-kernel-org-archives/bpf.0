Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA14339B3D;
	Mon, 22 Jun 2026 03:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782098000; cv=none; b=L2ekWJYLFy7ir/GcfiGk6SNTS3kJLFVcZO7xWVYOSDat9bLpZLsQrmyluM9Qb1djge6tQIAdNnk13MiKuraznoH/gsBuZ1cAVFM8YpMPBseq2ZkhKMFJZGHvzXx898QROpaiyuGLvbOxRhL+MmJS03xqfzZo/Ra3vw4eb36AZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782098000; c=relaxed/simple;
	bh=v/429bp7PoSijE4MHz4vl+mxy0WhUXiwgVbe0Om/OHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh4XK2udlnW3+HTxKUDmUgP2tfk2D0XLtNOncsFOYYrwn72mfjbgYlwfyMAOJXac1t2PyBMbZf1aGHIT4UIRdEyL1xsBrSCNrhnX5SXqTgI3QLo8QcOAmL7DloEbmR5efrKK4SPqTr/MiD3ug2omglixdrQKy9BB2iv55r91trY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=McqXISsB; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="McqXISsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782097989;
	bh=oFX124PFDB+bxKLrphSvL8KWkzIQ+y0wppU9tgQAmHg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=McqXISsBInQhITMr87rfXEFqRcKf0cBQAh17geSimzX+X8adlJLrdTOc3LW1fzS/x
	 XGcfKZKcAXefi1vuyUge/n65BQvaLJpk25EKKaNRdz9kW+eHfTKCbCehQHwttLkpek
	 SUSDEQP5UeLgGlATWecRBdBiWz4IdJpGu3OBYKHs=
X-QQ-mid: esmtpgz12t1782097984ted239a1d
X-QQ-Originating-IP: 6RJr/7UOIBZQW+r7ha1goe+eh01M37zdd/QelpGOb5M=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 11:13:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11911780816152163184
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH v2 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map commands
Date: Mon, 22 Jun 2026 11:12:54 +0800
Message-ID: <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622031255.1160657-1-chenyichong@uniontech.com>
References: <20260622031255.1160657-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MdzdX6p4PZzkgbh+7PjPx6YytqmbR9EkDZudVulY75gqijwtD9cUWVIk
	QAOwBdPAeDkhbfIR9MriST2A0rbEEK+ltQLaHGkiUK/+MDK9+dith6/+1/CXVTJUlkoHFJF
	SXEXLvhC0RtUW4lofT2OVVTC2e3GkQwtQt2PjNH3l1wFZc+4zH0B1aRMmHL58kRlejfdmYW
	AYQHwNPlQYJ/aET6vSGAKtkh3nS7h99u+L47vb6HsUJcQOSZsfK1kVPYtcuEhOMdxLy32Sc
	39q+HkGSGd+2i/qQm2yCM31538E9pjpLgmGdwp3yh+SpxiocxnzJmJwO8V/KjNcwGN7qaxJ
	t9z/GZ3pofbUaIDcuZOTaqIpCc2YjRzbdvXZPAHawz2A6DcDFDJfci9lo4OjHYEPSAF/MdV
	5r7F8j0IChYmRgJYpccIOAeiuXcLBGoj0+w5IQn3VjKsRImmu87vNzGXblHcR78loKSu0L4
	fOwYLpTwpFIFO9x3GfVaPG16JDlkmaEJwnK+0v66GsdA3nvWb7W6QHKSyiM4Avqjndivs3T
	6IqbZN5tSufX2Ys0CVP7LGjjm+DzMK96Sc0G+FM3Bo140r2/MnpVHSIJVWVyY/yqkPtJpwL
	tHmt7gpS2nIhBkz8/G31OaeOF6r3KYJEP+KkySfhe0I1B3Olv9zFz9D1Z3hKc05qVENQgEy
	faXRpEbpin65cs8vsOBk6mqm9nPK8HVoulpxMq6KrHNVQCKaQIZuOSk4ABnicbUDjFSbZtP
	ZvZIgOzO3QNh1lAaLNfdg34pyPrLtLZZvrRRfWZjgwYqtNYL5ab8lp7/1pFhgkLsigg5xPc
	gX86UjaWei7QEXQOnS6EwNsOGqZot1I2z3zacNItuExOLOO9eImXdy17BruDJnIG10bsN74
	xmFrfX62N5nqeCBSYKFmDSnkNH30xraiLs44zJzBGlw+18MlaCxDBoDyt7EP0pTECFwsW9x
	Km0939LtoybrMVnfOFyFh733GU9FzqKRIPQaYHHNs6NivtR5fveb3b5m7cQoX0LVfb2+ymC
	5IbAtNf7/tjfj/4YWRRlIJ2iI+ooVc2xom/G7V43ByGrQyEkiksNdvDvCiM3s=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

get_map_kv_btf() caches the vmlinux BTF object when a map uses
btf_vmlinux_value_type_id. map dump released that object when the
command completed, but left the global pointer stale.

The same cached object can also be returned to print_key_value(), which
freed it directly. That leaves btf_vmlinux dangling before the command
cleanup path runs.

Use free_map_kv_btf() for per-entry cleanup, and reset the cached
btf_vmlinux pointer when the map command releases the object. This keeps
batch mode from reusing a freed BTF object.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/map.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..a265ad3afbb0 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
 
 static struct btf *btf_vmlinux;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+}
+
 static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
 {
 	int err = 0;
@@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
 		close(fds[i]);
 exit_free:
 	free(fds);
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 	return err;
 }
 
@@ -1049,7 +1055,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 		btf_wtr = get_btf_writer();
 		if (!btf_wtr) {
 			p_info("failed to create json writer for btf. falling back to plain output");
-			btf__free(btf);
+			free_map_kv_btf(btf);
 			btf = NULL;
 			print_entry_plain(info, key, value);
 		} else {
@@ -1065,7 +1071,7 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	} else {
 		print_entry_plain(info, key, value);
 	}
-	btf__free(btf);
+	free_map_kv_btf(btf);
 }
 
 static int do_lookup(int argc, char **argv)
-- 
2.51.0

