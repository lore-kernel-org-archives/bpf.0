Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9E3FA5DD
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804945; cv=none; b=WcImweAFzReIAsgv8vIkrLkJrjwQxymx1o52dGHlxe1mIQ99GYf1nyr7BPInOTawlkvFNYCO5PkHpunJLZwC0VfOkABL78ts+goFY75nM74uI8rsfOpicu1RIjh4NJBFsbt1tgz27A2fPVTwQZnJpWfL4+eHpEhqYtEisk3Rf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804945; c=relaxed/simple;
	bh=/QREukzmkE+tXyTCwaLqTcmUTEKcIpO3WmpithpQ8Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBPOw9Kt7sVMih1X0NgdgZySt+C4MSB0ViqIUzyC6XGxHaxRvZaECRIFoJNaoXeYPOoFfMQxtQ3MJhAzEt0WYj/jOGB3ntMy78iMkZlysWCg/jYGtERFZ/mQiIqyPibUXBaZkTUuO4Cn22THPsT2TVStQ7OWQq3PmMFVwjHIfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8e92Rak; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8e92Rak"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49051422d55so33436895e9.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779804941; x=1780409741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOEIbZxHQvqfLsgmTIwg9+R/3mRTQ8/fMiowXJT30hg=;
        b=o8e92RaklRbtgdl2THaDuVNil792tg21F9T7CTdwu2F6aXs3y7vhDq8wr94TUPASYD
         /dLRl3ksu8+PkCpy5zwk+PxM2gRL2ARAgXzdOoV2nOkCGyJgd1N5S9+ad+sZlAmH8dQo
         /+UESyThVqEtoX9iUGZHZ/aLQVzDvJtql45veNcAbLcfD7ryRcdcPr72hZ+BmpCunaEF
         +4kkYOYVwVzpUVi5podScBrCHwXX5WLsuGCvia76NUN+4g4ErFYnjip99ipJ0p+w1u9p
         to2aDSaDnFw6+oBhlCWRTq7b0dJeb/yPBvDJW+cTZ4wKYqWrFJRCjwMlFM9U0EVxOkDY
         GApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804941; x=1780409741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOEIbZxHQvqfLsgmTIwg9+R/3mRTQ8/fMiowXJT30hg=;
        b=Y6sU7VK6hhN8nXg/vtVTeSDwzMcjfL5RuPbqiimESYwo8LEGRB1ALfEckNnEQJZgOV
         jy0CCnj6Aj+h1FzSvGGxPtIWAohuewqwZCgwbGFax2UfqY0kJKce842KlUIwRiSB1fUX
         2pT1NxpKxfxwwQZElK1JZ9lo4l9QYkxwUWZRbCEAGIu62CDElStDsVDteb2i6SrsNJoe
         HLBOCCjfB83ykagik/XreC6n8ZkNXuCWXqJTewNC6CQ0a6ddwYODnHmEXZEonS5dXDWa
         KZTGXH3l28PbhZqFMsSv7S7md+ufSnI1XMQUWAnduxzTMjfbesi9tjbTHs/QOf47bBjN
         iBow==
X-Gm-Message-State: AOJu0YyKDSynyb28fHoCsTx0JAwtK6Tviws5/8yQ7mw3thPxljvSlEw4
	JvnY9Ott0f9XGL1vKEF94VWGk+dGcWfzXOCe0dSb9wc3amSZ2zSXzuVLcUTlOggVad6TQsZWjQT
	6yWV/cF7x7kyn71cx/A==
X-Received: from wmaq2.prod.google.com ([2002:a05:600c:6c82:b0:489:1f08:926])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4652:b0:490:3b84:c106 with SMTP id 5b1f17b1804b1-490428d3b7fmr201488655e9.26.1779804937868;
 Tue, 26 May 2026 07:15:37 -0700 (PDT)
Date: Tue, 26 May 2026 14:15:35 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-2-5b4fa2a5e1a4@google.com>
Subject: [PATCH v3 2/3] libbpf: zero out btf_key_type_id for STRUCT_OPS maps
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

