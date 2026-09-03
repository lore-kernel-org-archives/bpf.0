Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5D4052A2
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427492; cv=none; b=YyASfxBeNKg+joUnA6l1rDJk7G8sdq1hOcr8lhRVLBZYnjqAJLxW40UhNOrM9fe+7M8DZj9lC7lfRBk37vT693kmB2f+Y3t+ZSDCeS5RFmeFlLlzGu2+lP209q0l1G+EFrz4xiyk8469sOoB+qGEY2M7n7sHkipuhpihJRq3Frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427492; c=relaxed/simple;
	bh=VyDh2sAfURfoDPf/8+ojtb+GDM22XkH1cDLNBgT6tNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+QU1PifcvjusPIyDpBU8+2yCOmUEuUx3g5LkU3vYlSB4Ez556/PjfiqxRrg1PDzPmDasnmltqF8G0k30jKoEKxEW6qQdugoTL7/Dw4J1Q9aYcnhmV4AmSZpfRFkUyf5u+hF/T9hyAqidmMw8qV/FkvZ5WDN0YtLSDywh98epA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQv06KNf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m/jhmzWB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQv06KNf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m/jhmzWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q44l5ZscEyQ6yJKKubo7c3OoKM9HyiRVEIpzdw4juK4=;
	b=CQv06KNfAZcB3OSt9vHvwhy2KEmQpuI9IdcwRr4xOeP37UFIDxEoT0qGkTxojoAnPJ5X3i
	pDkc0/i6rza+QdS1u+PLqWVy1LRbBn9eTs9Vqdb9suFUhEhYrItlM7VyQOXMBbur/aiDzP
	AGBmEqaKhO2h+oOiTCse5f3j4xN2E8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-H9-0hwoaNrmHwM91STNDFA-1; Thu, 03 Sep 2026 05:24:42 -0400
X-MC-Unique: H9-0hwoaNrmHwM91STNDFA-1
X-Mimecast-MFC-AGG-ID: H9-0hwoaNrmHwM91STNDFA_1788427476
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso18728435e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788427476; x=1789032276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q44l5ZscEyQ6yJKKubo7c3OoKM9HyiRVEIpzdw4juK4=;
        b=m/jhmzWBdWjRiAyCwfy2FsXlSUdiP25XViwOtSqH71SHNNOkaF1MhcPzrXeOxMw0KX
         vG79gA8T3YhADlteqUelhl53zIurNB5av36O/G8qfuxGhxgym7QHDRlfkD/gG5WXrOOc
         eW4xeAlIIoLtQMDbsUEn1rmScgjEbma9NMHFXYu3ALZiKTbpM5pS0UTSQNBr4Xrm4+Ob
         +N3KybUko2aTnHQNMGAe8mLvT5fcLRYpdvxac93Ij5w5WUm0TOcuUu1gVZ85BfzRcPbP
         dv/kLDI/dZecasIAh4cPkVGDDXKzk5Uxjzo681axWVkUq4qIEn3dXQXMzvbMLYcky9QJ
         5/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427476; x=1789032276;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q44l5ZscEyQ6yJKKubo7c3OoKM9HyiRVEIpzdw4juK4=;
        b=X/kYbDnKe2Czx8uvSrqdFSWTJms1DgQ0TbdWYNkUU78iYknCfMrsFvxqS+DFiU/ks5
         dTADuGH/gZEOwxHMUmjo0qhtntY9qbb9np/itJsiua8qNIVvLMiQ4fhQkGDFzvg3oIAB
         ZfnxEpSd01HxYA8Kny4gsdEWfjwWXmjgYEtYrxu0y9xccnb933ADctM3Q+6Bsq4l9Yep
         a4QumpcHyCyGGNVjXou6BKTRqEDaLoApCfrGJn/yfQnmyDvedFVBzSPadcX+6w8lPm7w
         duRT8e1HDeZZgc5Wvg3dPryIRCp+QRl2wGcUAJyjUzWkKoDk+xwkgdw6u7iHo+3PbhnY
         N2Lg==
X-Forwarded-Encrypted: i=1; AKwUvBwLedOuudRtKMDwERdkQHlQHE4Tk+fiGeT06L9BJw/ZXTHkZ1Exw4KtR8mV7fivNskIrWY=@vger.kernel.org
X-Gm-Message-State: AFuF++nvKUWqsXAoLjQn5QPjHwpEpXfnhPfTkWAesmS883W6KKu4bYmG
	7Mxc1mvyNOG6EIdcsOt5n3in8xGwR/Kiru2sAD7Y74Vv8tzXIC4sUj8T6ApdegVFA6vco9Mu4XR
	/1giwU4HCBcPDcBN+Dn1qau94d6ERBiacp6iFKq49QeNMWqLlUl2QXw==
X-Gm-Gg: AYBFou3M4OZfKl7Mw8v7TSUy2zKYpjOxCL7dVhH6XbPGvfY4YdEbwf8MZyJr5jd7xaB
	oxb005DVNfMcY+oHSu0124O+ABFS255jlpEWL3HwOl2OXA3DoA7kUMV0++PJUYSfW0nGY+JiCtI
	TcEiuOw8DS9WbNeRWRS4HzhVtuReRM3fW/kbhkQiEo5PVh6g5vlyXjuf+xtngKCe1AwLkoVecQg
	jKeqhuchyRVzyRITSZ+YlBWrUoygFyC5T6yC/tqGjeRwZoXT5uqXJBoeI58ZX4HOWKZkRUZD2JQ
	2llSgMD70gndHSx6+qdj7vZvbyZLyt7ZMUvaSG2z0z9ldTOsY7U6k6Jl7alXBH32F8DWO6sIVpf
	liMj2XgyeOYSGL2juETvmEAc5
X-Received: by 2002:a05:600c:1d11:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49ce582a54amr180717175e9.14.1788427476361;
        Thu, 03 Sep 2026 02:24:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1d11:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49ce582a54amr180716595e9.14.1788427476057;
        Thu, 03 Sep 2026 02:24:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm64121695e9.1.2026.09.03.02.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:24:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2399C97C7F2; Thu, 03 Sep 2026 11:24:34 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpftool: Adopt bpf_program__add_flags() helper
Date: Thu,  3 Sep 2026 11:24:11 +0200
Message-ID: <20260903092416.223294-4-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903092416.223294-1-toke@redhat.com>
References: <20260903092416.223294-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt the newly added bpf_program__add_flags() helper to
non-destructively add the BPF_F_XDP_DEV_BOUND_ONLY flag to XDP programs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8c2f9255b36d..6ab911e82155 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__add_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);
-- 
2.55.0

