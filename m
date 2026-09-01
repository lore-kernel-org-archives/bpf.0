Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94E473C88
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252436; cv=none; b=KVJKV2xOJfMbC6qG90bzfuGtPX1/G/g3rla6WHdx6JVHAAzHKv5OLYwOera0edNG0u5Ptq2xghTcQZ8bCbllbZ25Uf+2T3qY8qjBdQFTHo+TPBLwq1uxur1sySyVY00RnkEVdywbeQm6IDdF67FeHpJZZfvvI6zTuhDq8CHqcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252436; c=relaxed/simple;
	bh=Ug1KFsfJsMzBeekPEc+ZW4yfLJKZ5SoN4CdNkl9+Dw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFWTPYYAP3gCF8DoUgDWdVn/n0vnyDXhpNQ6nPMiBeHs0WQNxjuUKbg099UJG+/IMrP0qYFO45M9/B+1bhQzlXV0wJOkj+X5V/asBjtQviUxetm1xmxKf/l3/uZENrn18ip3xpDpuXgVNs+eD2Nh05BhFSqd40hEsXVklJ+HGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afXXaEQT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ngOaiGAD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afXXaEQT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ngOaiGAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
	b=afXXaEQTP1uATKGtB0eOBABIm3rqLvypJOfcL/CgYIbeeQwVwo8Zs3Cq5pFOdrorqH7i/l
	KkaYO3oDaoYq/Gw1gKfRjC3p+P9l8585LT7NyIbiN29QgtcyDuFEu5xaJxrvXEBY8Lbb9x
	Nc7d+JLj0U1LxTpl84mSvQZ0AnDuRHA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-u-0SGMR-PaSaMgDsL2RtIA-1; Tue, 01 Sept 2026 04:47:12 -0400
X-MC-Unique: u-0SGMR-PaSaMgDsL2RtIA-1
X-Mimecast-MFC-AGG-ID: u-0SGMR-PaSaMgDsL2RtIA_1788252431
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so41025035e9.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252431; x=1788857231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
        b=ngOaiGADhx4yMOUZ2ODAJGJjhIOxnt9sTYpwGS0030I6DBKJlm/zn5Jj58fJsu27Rz
         3cgpuFE/ixq6/NjAOdPWUjf/rlXDS0mh8nyXflXUnTJ+SBw/AJnJEI5rqxp5ydGkGg6d
         j8G3T/gfdD2NyyI4Vvvy5iCrxt9edDDmOvkI0tyo08dSGc4Sq6XzSFOFeLdO3DIRg0NG
         CMOnUzH45oBZdfbPPznn4/+qfk0PNa2YSzpgGEErPe5E6OFAROQ0+pFHlMDq3htTIX9Q
         kq07WhPO5/MxYJYSfJY0j3q2aFgytaRHMaeD+8QZKiIioAm/5G43hSYSAhfg7IEq+B0x
         quhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252431; x=1788857231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
        b=AM1FLUOi1waj9aX9wqDYspqGT1VzssgP5uvP0sUaTA4HS38d4Szq62+RaYXNL+ZGWY
         y8StZWgsE/6NYf7Q8N+tQJjp8SWPTxfi26dn2lFZqv6Wy24lCizkNmS4LsCHDwlh85gK
         kh93KP9sG847cRhD6txnJEuMrM3ixF4XCYADjLduKN0CRCyTHD11qQ6G41UMqOQaOCPL
         ldIof3gYIi8bIcJyWhw7eO0DeFwDqfNfijXoiLUgiiLfFSS3WfMu3Ch5MfiYjBnUowXj
         yJiWJC7wfi53Ykm67oB2r0yJT2wjXoo/XZWcD4Y2P1IQmSc/mr6UukBavzTl1v04wr3q
         dTCA==
X-Gm-Message-State: AFuF++kBWC5tIOMh5/i6YerMgTclC7B7Ov3SaF5G2cOjQTvDgrVoH9jF
	xLLjc4yENsJHUhgrSjigbLQ+CrkEkQWE/w911/2LmZOqe9Y52I9bpijLruA3QXe1S/Wx5JyJqOV
	kWgfuWc4pdKGYROQ/FeRKbzrZlEJq7VYdd9vJW9jEQZEwVI5HKzkx8g==
X-Gm-Gg: AR+sD10P5uA0jk6gpfVxsyxHx541Ebmi5AGeZNnZsus4TgiOBwmMQnC3vdPo0uzDouk
	j0I+GGn/qEAkCRD3RG91rwpjpCS6STtWtt78FHD1mOi6kkJVhNKXgShcmweZG4AVLKTn0yF1yZB
	E9z3EjpOHJjuKFY8Iwkk8XmCbB7mxu6raQpCS/sQDskv75r680Sp/BkSW2WeSQCxMJNdJ6ZG6ar
	RViPhuu4BD5lYWngO3D82PoarOz2sEloAmWcUBigw/P+jNxYiVxL1pxQsTzQ2Zrk1S5BOMUoJHc
	xzl/dHyHHU2GKAIp3qvgBD/D7hB88d1MvzApqAWFYK5qOINoclnQYcxiy/+Eeci9lb/wdeGnvNG
	O0O1Nm4l0HZtcWD3HLcmsePpoiEw=
X-Received: by 2002:a05:600c:a00b:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cdc2c214emr102805285e9.2.1788252430714;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
X-Received: by 2002:a05:600c:a00b:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cdc2c214emr102804265e9.2.1788252430227;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1e3a9sm51551035e9.15.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9950597C524; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:56 +0200
Subject: [PATCH bpf-next v3 3/4] libbpf: Move section-defined program flags
 to prog_flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

The libbpf section definition modifiers for XDP frags support and
sleepable programs stores the flags bits only in the private section
definition cookie from object open to load time. This has the
unfortunate consequence that API consumers cannot see (or manipulate)
the flag between object open and program load.

In particular, libxdp has special handling of frags-enabled programs to
make them compatible with the dispatcher. This doesn't work on XDP
programs that enable frags through the 'xdp.frags' section definition
because the flag is not visible through bpf_program__flags()[0].

Fix this by changing how libbpf loads the program flags from section
definitions: instead of using the private section definition cookie, add
a setup function to the default section definitions that stores the
flags for sleepable and XDP frags programs in the prog_flags field of
struct bpf_program.

Exposing the flags this way means that any use of
bpf_program__set_flags() will override the flags unless the caller takes
care of updating flags in a non-destructive way. This is unavoidable
with the set-only API, and any user setting flags unconditionally is
already broken in the sense that they will also override any other
current and future flags.

In addition, prog_flags survives program type changes through
bpf_program__set_type(). It is the responsibility of the caller to
ensure the flags are cleared if they are incompatible with the new
program type.

[0] https://github.com/xdp-project/xdp-tools/issues/587

Fixes: 082c4bfba4f7 ("libbpf: Add SEC name for xdp frags programs")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..27779b4cddd0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
 	return 0;
 }
 
+static int libbpf_setup_prog_flags(struct bpf_program *prog, long cookie)
+{
+	enum sec_def_flags def = cookie;
+
+	if (def & SEC_SLEEPABLE)
+		prog->prog_flags |= BPF_F_SLEEPABLE;
+
+	if (def & SEC_XDP_FRAGS)
+		prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+
+	return 0;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
 		opts->expected_attach_type = 0;
 
-	if (def & SEC_SLEEPABLE)
-		opts->prog_flags |= BPF_F_SLEEPABLE;
-
-	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
-		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
-
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
 		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
@@ -10099,6 +10106,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.expected_attach_type = atype,					    \
 	.cookie = (long)(flags),					    \
+	.prog_setup_fn = libbpf_setup_prog_flags,			    \
 	.prog_prepare_load_fn = libbpf_prepare_prog_load,		    \
 	__VA_ARGS__							    \
 }

-- 
2.55.0

