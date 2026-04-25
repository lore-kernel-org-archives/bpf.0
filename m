Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEEF33F8D9
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114815; cv=none; b=aE8kNKs7T0q9cYW+8pezeIjZL1lib9OGeXMPmK1rkv0LhbSliY4zXFvhfEVXCpv/5wnFWGiQwpVB8aIbBCtrHNe9dLgG8WtqDZhHC1NhztZHtJQWrszaT97Js8oZt18Yfc3P0mS22THs4a+/xwuYOjpUbwwcE6fr5Y8IR6+tD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114815; c=relaxed/simple;
	bh=02Ul6939AS0EQ8q8OuYSELZ/DXt3EKcfFhLYsn/RYm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xoez6m9lFj1NvvItXULMX8LSUDiitm0Iumf/Ml3y01+zznw0qRxJwtRC0cWetEbxiHUnmyUhMW0Kvqys1ID+1VqNFoYdDcXQG221JeqLcAvgGNfI4D7lZ36C7qoddSHorsAzyMkE0gJ98UbKuZ0EU/Wr9uFv+KoYYsvwG4HueYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJhx9bUl; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJhx9bUl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777114811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeip7Q7ShmJCQllW+fBDrj9Sp1DOAvtjLpFx+gnLJKY=;
	b=GJhx9bUlXmtZ06pyrcmeELFy7yib5jYEQRuCEnJA8onrIckrgm0VAVze+58iAd19CFRvm1
	wXw38FiEyjdOdbCejye5qxTRfsFgdR0J93LI2SRH8SsRS5SBXB3PTHY8Da5AL+nv9zJ1L3
	fxENjuYDOYScJxYeXDORM4gQrxUpyME=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 1/2] bpf, tcx, netkit: reject offloaded programs
Date: Sat, 25 Apr 2026 18:59:28 +0800
Message-ID: <20260425105942.223757-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260425105942.223757-1-jiayuan.chen@linux.dev>
References: <20260425105942.223757-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

An offloaded prog has its bpf_func replaced by bpf_prog_warn_on_exec()
during bpf_prog_offload_compile(), since it is supposed to run on the
NIC. Both current mprog users, tcx and netkit, dispatch programs via
bpf_prog_run() on the host. Attaching an offloaded prog through any
of their entry points (BPF_PROG_ATTACH, BPF_LINK_CREATE, BPF_LINK_UPDATE
on tcx_*/netkit_*) ends up tripping the WARN on the first packet.

Ideally this validation would live in tcx and netkit, since "must not
be offloaded" is a property of those subsystems' software dispatch,
not of the generic multi-prog attachment layer. However, those two
together have six attach call sites and putting the check in each of
them duplicates the same logic. mprog happens to be the only chokepoint
shared by all of them, so add the check there instead and scope it to
BPF_PROG_TYPE_SCHED_CLS via a small helper, so a future mprog user that
legitimately accepts offloaded programs is not affected.

Use bpf_prog_is_offloaded() rather than bpf_prog_is_dev_bound() +
bpf_offload_dev_match() (as XDP does): bpf_prog_dev_bound_init()
already rejects BPF_F_XDP_DEV_BOUND_ONLY for BPF_PROG_TYPE_SCHED_CLS,
so a dev-bound SCHED_CLS program is always offloaded. The simpler
check is sufficient and also rejects attaching a program offloaded to
device A onto device B.

Fixes: 053c8e1f235dc ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/mprog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e85..0b50464ec902d 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -222,6 +222,14 @@ static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
 	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
 }
 
+static int bpf_mprog_check_prog(const struct bpf_prog *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_SCHED_CLS &&
+	    bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+	return 0;
+}
+
 int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog_new, struct bpf_link *link,
@@ -237,6 +245,9 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 	};
 	int ret, idx = -ERANGE, tidx;
 
+	ret = bpf_mprog_check_prog(prog_new);
+	if (ret)
+		return ret;
 	if (revision && revision != bpf_mprog_revision(entry))
 		return -ESTALE;
 	if (bpf_mprog_exists(entry, prog_new))
-- 
2.43.0

