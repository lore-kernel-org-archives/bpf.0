Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF571C5D44
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142797; cv=none; b=Epj9M8PqzsDF7WOtkmghEhOURSx6TDljc3AEv3tZ/9huHbsG5KfB7V4KXFvQIMIJrBS0PrWD4+jN0dk27rjIyz48g2RgAVLj5W2Jyxhwg/K3ZgSL7gaorqfV8wslYZib2NG9M2UmHZqPhZ9wcjjpc6j7vrtgLJznySrOW0k3SGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142797; c=relaxed/simple;
	bh=qHYj6BnF2ZmkdNLxfOIr6rvNkRfvUdJGRVcKPh/ZleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QZWTCHsvLitG120JykqHjTRmoBgKz53DRY0gYeju0sRslNlPiaWtykB7PU/zmP+4kQG0nXDdpo/TNGjSjuLxei/H1R+VkOWlOsPASJQ2eQ387p3cjUXPBfLsEemCbHANn6rw4IdRKhxZ9QA3guqH2akUa8fwifygcdMltq4UnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBNgcKzk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBNgcKzk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439af00d33cso9836397f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773142794; x=1773747594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qv3IPY0ZwvIDHyTjh8uPQFTRsBrS6LY965PIEOlrLzM=;
        b=gBNgcKzk8k87bBMiVZUymIReLUYCXEtOuRFIK4Nvh4D9O4l3gw3n714iwTNk4W+G4/
         hYR2kigjGZ3wg/tGknmBqdsakGgSGCJLxggtBV/kO1kPnPxrqQ0cs40LYO3NAweg2FSh
         yWbaOt2NpAVmyl7gDKPeTmwjTxaEwy2Yv1pChQ2rvXkDM7ViUZVdneDThaDAyXMPzvGu
         mWRLrcmohIG+6JkFvqxnXQmEWTqfV7WlWPnSc7J+BfK3wSR4LDS1YZlDtAqXsDT6hqdz
         DINqphk+RtmpRYMa34ZeOxBst6EgSKd+UJR6BaPeg2bCcbXfo2jJB/cjNiWyaclxS/h8
         1+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773142794; x=1773747594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv3IPY0ZwvIDHyTjh8uPQFTRsBrS6LY965PIEOlrLzM=;
        b=tvB4TXpko6AW5BghU2Lyp2ipQeOTUZgVZZutFBagTBUngEeR/Gsm+q7yJV6kvEw8H6
         VJh4ZmQx9ss/BTr0oC9Ozo1NktByu+/+mUyAC+cgIj875jivteicotwqD5rBqAVx4sfP
         H+M9nPtWwin5IfUFtt/P/racJWt3OWY9QSlLAsdAq9nObwAMzTuHGoPiSG2pVneE6ZOA
         okw4HnCakK2qtP4g4lcBZMYHI9UcEYHl2kZZgXCkwLy4zybWohLwGj5OAsyMDLks6gJw
         oDK/8WwU4w4vOVP2qplmUaOuxF9PXacpwVrdHevuXuDh9bBXN5msKiy/dIYlKy9PJ/f+
         fBjQ==
X-Gm-Message-State: AOJu0YymsDowVsE5lA8AH2Y3v3GCO7M6wztium46I1oJ6CyLlRlhhT2+
	1dvx16LSIv069oGf/O3GHaj1jr4i2pTR43Sew1N23+W+gD3ECL2Qkhbo9K6SB0J9
X-Gm-Gg: ATEYQzy/ZPfsNSiIxyJHRi0RQo65IcO6Cbq0LTbplbO8W9NQ3WeyIpVsZNzfhaTxyl6
	cX0yX9Yaxn2j7d2f5O06KOcPi/r1sIXOReK0BoKUz3XhmTbZOHOWabW0KRBgpNjSRqaP/eQeLfJ
	1Dxw1ZL/HyAaoi6z9RqnmZAHcuBCwOZ2pdZut6VEMB56PA3426fO3Kwv8wAInRt8XAgbNc+hsdj
	Pr3PliMmvrYAB1bL0arXDfPK+1pqExqMDK8BfFHuJSgjZJm0CxRv5S66dUICRRvJEelJ5r8krm8
	TQNgRfk8lP3iZZAN0ThkkH9KesTNoYUoTs4tOLqgaY4yD7CvtN+e1Jm/2iCPdvhh8ckjiaxDQLY
	2Zl3n7c0LbTCtToUED2uhJvoUrZc9J/Gja5UxGfTorsx2WzxfjBkk3fEYDOtY3z/oGYVvwOPiGE
	QJ6DSy8MayDGU2iaSuP4IT1Nk9smrDvwVOm2EEtfPnuxHqw9FQzGcVFkIHWB+OLtQNeniHSzzEp
	X4RJr44eTEbesagKbKHHy0wtlsa3kgKpwwkvKLSmf632jQ0iaCqGliOEkaiX6ADCYYKJrz8XGmI
	gukYNdydU7g=
X-Received: by 2002:a05:6000:1846:b0:439:c550:d92f with SMTP id ffacd0b85a97d-439da89d7bdmr26657883f8f.56.1773142794259;
        Tue, 10 Mar 2026 04:39:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0044a2d5868b861193.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:44a2:d586:8b86:1193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae483desm34326804f8f.34.2026.03.10.04.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:39:53 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:39:51 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH bpf] selftests/bpf: Fix pkg-config call on static builds
Message-ID: <abADBwn_ykblpABE@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For commit b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection"),
I suggested setting HOSTPKG_CONFIG to $PKG_CONFIG when compiling
resolve_btfids, but I forgot the quotes around that variable.

As a result, when running vmtest.sh with static linking, it fails as
follows:

    $ LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh
    [...]
    make: unrecognized option '--static'
    Usage: make [options] [target] ...
    [...]

This worked when I tested it because HOSTPKG_CONFIG didn't have a
default value in the resolve_btfids Makefile, but once it does, the
quotes aren't preserved and it fails on the next make call.

Fixes: b0dcdcb9ae75 ("resolve_btfids: Fix linker flags detection")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d5acbeba0383..65485967c968 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -409,7 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
 		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
 		EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
-		HOSTPKG_CONFIG=$(PKG_CONFIG) \
+		HOSTPKG_CONFIG='$(PKG_CONFIG)' \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
-- 
2.43.0

