Return-Path: <SRS0=pAHC=C7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DBC4727D
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1C620756
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFCqTj7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVSjO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Sep 2020 14:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbgIVSir (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Sep 2020 14:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600799926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKOJqVkCN/RDCAG/fTLRlqx8WKM+s9hALBC3BDKVQU0=;
        b=GFCqTj7jxNpigfx+t39hxG118ub4UZMZds7SxfOyFkQPqe39k5P0T14AXdtTa8r1bqvc5i
        OMQCDHYYOazJt9w6T6COy1fQxLDyAL8+FX7HWOVIepdl0pq8QOz1KNYBgSPKvRlJS1dCx9
        wJUWPUCwxr0f2DM8n0vzRc8+6OGvj7w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-febOEr_TPxKVG9rIIWokwA-1; Tue, 22 Sep 2020 14:38:42 -0400
X-MC-Unique: febOEr_TPxKVG9rIIWokwA-1
Received: by mail-pf1-f200.google.com with SMTP id s12so11953039pfu.11
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 11:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pKOJqVkCN/RDCAG/fTLRlqx8WKM+s9hALBC3BDKVQU0=;
        b=DWmHXT0CQOBdxBCv8ijzHiMqxqtAEsIKPCLKFFjQJCrzfeUN4zF6+ZOrGtJxDDvF4i
         0i8+Zd+rynBTjMfoggTOu2tg2U7j2P7pF6mdWL/+hTB6Y84j3fUJfOpGLMl7PlYyRR8d
         OiOrO7RzeocuLXMVJqKTvUH2mHg7xsjADnAPEKXy3ks3g89d0cara5Q57M0CbOxksAkx
         vuvLbMd8XBKtOaoX7Bc6A01GB7aWm5rCDZ989qOK7Vjn+cd6Kpe3O7PcPBjFCjy98tZv
         NAd5TxNlja51aHi8JiAylOorodnzmr6re2Rt2zdjrJDKMR9/nWWKLABB5ZYG4xhIXKcX
         GKHQ==
X-Gm-Message-State: AOAM530b62uu5fGlyMyaLuu5Oym+HhbXQj+KDKKwbZDCsBX/fNAttg8b
        C7xB7KrJM1xxngYC2oQ6bun/r0pXIBzcCM9Xk7aTNwvhERlLepLIH+NDQC2ThvGN2RJBPHU+Aya
        o3JMO05xcRjcz
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr4575543pjb.134.1600799920900;
        Tue, 22 Sep 2020 11:38:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCZeuWwb93bPgoVTUUnceQtdJ+M6ksucVYQzdqoLFUlO3fKUXW3k3fqDp79XwLminT/RTtmQ==
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr4575511pjb.134.1600799920545;
        Tue, 22 Sep 2020 11:38:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e1sm16768206pfl.162.2020.09.22.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:38:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E46C5183A90; Tue, 22 Sep 2020 20:38:34 +0200 (CEST)
Subject: [PATCH bpf-next v8 01/11] bpf: disallow attaching modify_return
 tracing functions to other BPF programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 22 Sep 2020 20:38:34 +0200
Message-ID: <160079991486.8301.10483022567832542496.stgit@toke.dk>
In-Reply-To: <160079991372.8301.10648588027560707258.stgit@toke.dk>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

From the checks and commit messages for modify_return, it seems it was
never the intention that it should be possible to attach a tracing program
with expected_attach_type == BPF_MODIFY_RETURN to another BPF program.
However, check_attach_modify_return() will only look at the function name,
so if the target function starts with "security_", the attach will be
allowed even for bpf2bpf attachment.

Fix this oversight by also blocking the modification if a target program is
supplied.

Fixes: 18644cec714a ("bpf: Fix use-after-free in fmod_ret check")
Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15ab889b0a3f..797e2b0d8bc2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11471,6 +11471,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 				verbose(env, "%s is not sleepable\n",
 					prog->aux->attach_func_name);
 		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			if (tgt_prog) {
+				verbose(env, "can't modify return codes of BPF programs\n");
+				ret = -EINVAL;
+				goto out;
+			}
 			ret = check_attach_modify_return(prog, addr);
 			if (ret)
 				verbose(env, "%s() is not modifiable\n",

