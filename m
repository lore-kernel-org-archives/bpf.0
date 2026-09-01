Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBD4756A8
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252440; cv=none; b=l0/ZUP/+aEKsLkwUZaE8avGkB6s/th+i9Sn0NulOl553OK3xkV1l7BR28rWzVbNL6F+d5WPMFn88OCbQVAOUNyFyNEzXsuRtRRdgC2lICErsYN+7MKjxriPRYzOHHR0vXym3CQyJgVTj0otUbWMDEgpTUVP8P6R+dhtyFoU/jcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252440; c=relaxed/simple;
	bh=0GGbVa7pGEqnfK1xxfikC0+J0qIxVkU6eehcukiHxOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b737QqXLqwVZ+bqbGLP4eooWntGxXO0qDBPduGS9QJpnBvI9szbzIcxi+m3vydDqk2Xw+PRhIvFr9ECXhvOwmZ3O9hz1TKech7WKbCQSLlCgUbtEmEmDIu4NQh5DPXGjkDIlQpVZ8J7CcB0EKsI0l4xUVgvfGjvSEyzs5p+7tWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xogr5U3G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdQJPwbB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xogr5U3G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdQJPwbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
	b=Xogr5U3GE+MSkYsROwy+0mBCz6xkTHl+TkItjhaV7HAHL5LmP8C41OIvQtNFgmaV/bLuND
	j8W6GHxbH2cEtSpKSrDPj5nvGZodqNMSBqK8XB4rG7979P7NQ7SKFdz7/syuifsPdZu3JN
	GFwCi8mQWscOQYkpTESSZ/ZtNsde0r4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-YPq4tG3sPYi0oAKbvQ0I_w-1; Tue, 01 Sept 2026 04:47:12 -0400
X-MC-Unique: YPq4tG3sPYi0oAKbvQ0I_w-1
X-Mimecast-MFC-AGG-ID: YPq4tG3sPYi0oAKbvQ0I_w_1788252431
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cced8309bso5036165e9.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252431; x=1788857231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
        b=cdQJPwbBTbwn+M1bGKmTdtpr6N8Z+cFo6ydDXIhBMLtqZD11AifXy8wW/t9AjOStun
         /3F05faCMGFJ5Y/pHiQuDlm92hD4XgAtPd5xKgU+ckr7ajYiloESwKA46sUVAeVGQB/n
         y3Nts4+DQOvZFZ9DAUyrrhOAi8MZwKoaiEdTpBx8HMPJKeqMuGLzLVBo2T/pIdGkisUC
         bqb6CwctFHj8avKF4FoqbJXy7q7lR+Nhu4V2XswvcQVBvsDeSU3oiGHsEnMB6b2CeGbL
         P8Q8wkXYlponQsY7us9rClcKPv7IeI/H0D4enSlPG/GtUVFY71GHCjVlLvz+IO8Jzgli
         QjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252431; x=1788857231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNbo1iN48NrRCyCtQp0s/FOdED9PELoFfdAYNjqH5b8=;
        b=IuiFiIL5ghgF4UNx9ceBEA0H5M5ZOcJXjJwQgItCFx/tx1rsxhI6h/RbptLDJf5mlE
         gdWa9awHasLYwahvTTeesWHX+nzkHZfZFRhkwEkRTEqoQQcc9Gm1MUH+Um6i18EVirFl
         tUY3yUE46cChl3hqtn19YW3jH6oMtXJwxayE6/IbMCyz+EuqqAVGfEtU17SHB5Cpapgm
         8z2ZMeD0KXpESBvzKwWsj3F3+3HyPExgfJxu9LjfX7XRgSFjB7Y+LIfiSP4GK7vLmgeT
         p5ffF+u8C9Q3Ys5SOO+0RmAvdq1+2fpyzOt+uZmh5dPI8tp/DbT1gsrFUzHend6mL33t
         Q7Lw==
X-Gm-Message-State: AFuF++leipOGYzzzeEzHuBWHa9BBXn0X1yns9SEAkzHJDfcw1Ax3gspZ
	C/ZwnQ5/wgHhTheLekdX0xeaPoS4cdzfk6SFjGNoWWCiyAY3qHbQCo74q2jgkPsoG8/X8KuKIiV
	cUyaVwds2FcAa7BCrSjKSbwikD46bZSXO05eEVXdD66lr+7frk/zK8Q==
X-Gm-Gg: AR+sD110kJOEQdn3sOUcSpacDE4eLj4fORJkkvl+TbU5sDRFTScpk5ERJk8lbws6VRc
	bD0Sh29ye6YnvRL++8jJCTq1iuTfl9ni9KcjJh6b1Spks3DNJZahIjUJDPjWJMicXdPBkjrT8NW
	RlDojprGCBK42V2X3yU+RdyjizRgZK9nAV+y1x66YemjaoIi6ZJ+CEikaTRy+80xCm5DVVVMx6i
	FKtbuzy7LzsGdusfw+9RpD+aRK+EQpXJyALVuluAkgkOl6kblVq6tgTt8Q3HPAoE9wPEG9Ynxe4
	9DLzuYyS6CjlTXmE25CeMFq7kOVGrxe4CYMzjhOh8NqdqoZNudadV6O58DgHfl6AfI+4MEw3jny
	IwaqGdIEn8ZzypGZfqn9oZrQb
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr482106155e9.15.1788252431321;
        Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr482105375e9.15.1788252430925;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce18dbae2sm7383225e9.13.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8E8B297C520; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:54 +0200
Subject: [PATCH bpf-next v3 1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY flag
 non-destructively
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
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

When setting the XDP hints ifname, bpftool would set the
BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
overriding any other flag values. This was always a destructive action,
but after we change libbpf to carry the frags section flag in
prog_flags, this can impact bpftool loading of XDP frags programs.

Change the flag setting to be non-destructive by OR'ing it with the
existing flags.

Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading program")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a9f730d407a9..8c2f9255b36d 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);

-- 
2.55.0

