Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C83E8C6A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797586; cv=none; b=MKqzkbsZyI3HnJYL1EZ8O3Ts2zcd1BvNfTZty/PXvEMTOU8Wleh81sT57e3dekc+iJ26XuFPmZhm90yoQguBQLEnMy5ws82pagPHS+mHgvAzxJTySZ8HjZ9D6EP01a+3G6FqEFGqqcMGkgSpRoGQtrEICKg2qWCaIBTuJI+S+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797586; c=relaxed/simple;
	bh=/QREukzmkE+tXyTCwaLqTcmUTEKcIpO3WmpithpQ8Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOoaIisK/+alxf6Wkl8F1QjJA9iYB98Ck1S+OqJUfmE2Vr/qmbH9+lTEQxhUOd1TKCHgu8dz491rfTBUPkImzV/6ElE8mwiooO3+vZD2MJND9LvOxcwEjLBUVrQLjhNY0krGgknSyLY2h9mruVf3dcqYCyIMC5wjC6SXXtbC1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGzfXxAV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGzfXxAV"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44a52d5e572so7323273f8f.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779797584; x=1780402384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOEIbZxHQvqfLsgmTIwg9+R/3mRTQ8/fMiowXJT30hg=;
        b=JGzfXxAVSdw6PTjkbNmfs4KYukj22MbI6Y6o9IwZIU5bkcKjM3GtgSt/JeG+u56Hzz
         xgiwkmAJje4y/YiN4gQTiSQ/LehPnhVw0S8ZM3rpG9Nb/UynKHx+3njCwJ5lr/96igOd
         F+zBTAhRsiwQoYJMKiXciKAUOzc23NFnMG7UucclN2GUhP9s3o7XzNoUZ472d8Lj3dvo
         D3gXfPQLSaOQVC4bGnRxD78fGMg3rtkgy5y/IbHGTyzAVxfk5pgUpOZfdKjS61fNZRuc
         O2HFp/m4RMn5tmi95n4o25MSckpd0k0ZK7VvnATVuL4S4Z7BNcSFs5+5uwo+jH58PAi7
         puMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797584; x=1780402384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOEIbZxHQvqfLsgmTIwg9+R/3mRTQ8/fMiowXJT30hg=;
        b=fCnw8w2lLsJR1q6t89G0Uz6IDdbmEh6soQS4+gyvIfvOZbpKtfsp8UVpbVprVB3CZf
         B+RvK3IEsZbMQoQZHypFg3YHXEdpbB81rX0jJu/JdHKP1A1yJ0Wtz0Zz2KV5463EcX/i
         GZbxRXV/dJXvgr3nFPs8GkxaJTy0hyrrflAprqgRZSIqRShimi0UuVKLpLzbaw/rWb6+
         Z2wvt+Dvh0MKIDGjSR8QLDroCfuwnymbCrKmbBM4+GUhEuFY94RmCrVbX0ARyg2pspTd
         nzTRa/7j+dbENx19PD76V4683fQhv4qKkPODvOVCqSr1TFLondpFrgDb86pZXlN8/IcT
         8oSQ==
X-Gm-Message-State: AOJu0YxZlqgAFDgEGkpn6/Khu2NEvpqnltxAhknPcYpLDRSWu3RzL/1V
	dKhuYQc22hDDBQbc9uth09KwqnF/Zb6bVldy0nHEoUgwccmhOIZrI2OBZszbBkCRoVKn/ezcDu6
	GcspMIkeaONqqYJOCRQ==
X-Received: from wrun4.prod.google.com ([2002:a5d:6604:0:b0:45a:e20e:d6ef])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4812:b0:45e:73b6:d107 with SMTP id ffacd0b85a97d-45eb38bbfc1mr30217434f8f.41.1779797583340;
 Tue, 26 May 2026 05:13:03 -0700 (PDT)
Date: Tue, 26 May 2026 12:12:57 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-2-6750f5859bc6@google.com>
Subject: [PATCH v2 2/3] libbpf: zero out btf_key_type_id for STRUCT_OPS maps
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

For BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps), the kernel BPF
subsystem enforces strict map-creation safety validations inside
`map_create()`.  That is, if `btf_vmlinux_value_type_id` is set, the
kernel forbids passing any userspace `btf_key_type_id` or
`btf_value_type_id` (they must both be `0`).

However, inside libbpf's map-creation options initialization
(`bpf_object__create_map()`), libbpf zeroed out
`create_attr.btf_value_type_id` but does not zero out
`create_attr.btf_key_type_id`.

Fix this by explicitly zeroing out `create_attr.btf_key_type_id`.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb1b7ea884a7..9969de42da41 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5439,6 +5439,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		map->btf_value_type_id = 0;
 		break;
 	case BPF_MAP_TYPE_STRUCT_OPS:
+		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
 		break;
 	default:

-- 
2.54.0.746.g67dd491aae-goog

