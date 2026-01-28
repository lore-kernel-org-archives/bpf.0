Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911B288D2
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559255; cv=pass; b=RNHuhkiYIIQsFgajtXvaokETZHZQPF9uEDg9u4Mc2cHkMbAPGifLlGItwlyl1yA9nhcItM4/j+tz5Lf3u0r8yjEWQmKBpGlOtfdGinYMYmI6tkUTejJGm9IthGtrSojihJz3Qx/osEc/iyR67E6c0cjEo/h4RvPBMIsgj6dXuug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559255; c=relaxed/simple;
	bh=Cbfn//EzJunEcY1KL1moHR7BDCmgxCbvpNOtHM/nWYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjH3rx0gKJf7D3fbgi5pd7AGXCoe7uyDl0y54TQVwGhu/nn3mwomK3dtgvZFSKLOrdu+E7J8DTbj+LiEeBMEgtsOuOSlvvw8r52yUArJr4I+JgsHRu5ihWlNeKAnRwYE9S1eTV8t6eDFzzwsRVewYWdnBXWIUed+8WPUCsi9LuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq53SXe3; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq53SXe3"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-435a517be33so3860993f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769559252; cv=none;
        d=google.com; s=arc-20240605;
        b=gITPKh9pn8Xu1XleP1e7145k26updL+MEF8R0eoncx0xW9ChhNR/g6TEWPLlfvyAir
         GaXJ7PQetdeYgZp9Th6CEszKM285B6S5eD4hSPdGjlqhffbG1kNNz/ZcHmVMfmnXGHbX
         tQlHB0+2Xu0xavk0gWtt7r9GxcpE1FeuXcYhsg+4AiVKQdTpRHK7cjaCcBUkTM0LGZO1
         QajrEThQDwY1Wg8y9uXH6O2kydnFYwSiBK82WZy/huAYRVGBVjpkplb+ACerxoV1SJr9
         VOSTDylCVxw4UUCQ711s44pADapbpwFaTW5hkxQRtiwkIi15RyO3R6Jh3glIObhA8rHh
         Ii4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S2rjjDA9iBnrQQdmHlnmu3/eAaG6gE8qMU69XsX+EIE=;
        fh=QFCKBz+bFHUY0exaAOG6K9Mhs13GMv1YfVf4ZOBvWic=;
        b=fOpro4pCeNOX6O5F8oHhZjw1ij2h7MAdSPYKB25Pm56lWBUt/fVW8zD7mSxDgF3uhs
         AAnAP2H4hz9R/kmXxBgIzXFj3R6cUv0q/vMIMldTNDJ8sw4zgpeRjhy00HKVVCrrTLWO
         cNB7nlAnlyMVWfAT5ChC4HVOuHjEpJ19+lGdqX6yivAZ1RBngWRStiht5mPzDN+qxjO7
         QqTXrDcACMQoeOs7OvUpokzX5svp8I/s9DCv2YkCJzxXT3nXe4E3rys6H/v55T2ohO2z
         XKIytNxNk6sfu6Cm787H1MNIDZkHC11RnWcobimcp1cMNT5g2RdUrQ/T4761Zrwbot96
         Dxkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769559252; x=1770164052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S2rjjDA9iBnrQQdmHlnmu3/eAaG6gE8qMU69XsX+EIE=;
        b=Oq53SXe34aqCjZx1bBWbrjtWiYt39QB3WlpctHMJ9EfZCXZR5ePA99GJf6zzTwxzFe
         0ed/GWkOQN6NVrDJro62KdJncVgwwnaH1JEauhMmbYgJ/GEdSZ7HIia+LSCTEJG2D81w
         uEXDBcsL2Gs9pboRbCoFjze6f7rXDRi20/d9JeyI9mfTiamEMAd8gPEW/fvBbhz+nVxZ
         KUQuVN+ZEO7F1hSWrX0pkzHiToYwTWo41dxNwwJ9Si7UdthGl6f99AwMrer8K2R5GCt6
         aa6/ST5+8iSkVL8LR1KDsEADhAj7AI/dCDY+B2lz4rGOAoSCMh84ZcLyVsFCdjeKmfwn
         /vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769559252; x=1770164052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2rjjDA9iBnrQQdmHlnmu3/eAaG6gE8qMU69XsX+EIE=;
        b=XP5esWeJmpfzqZv12e9UuUksHtvZVQvppVm3deYXyPcBektqTYmXNzVN7CWl89u1cE
         xKYqgGZdHsaqa2QdgiCTSi+BIqlktuYiPHSly0M7CjHkKsLixGu/8cuv3Jj7q6MrM1xx
         NimoHxZkcNkPoZbc7XaPwdpuXyuqhL7aCj2PQxo3dqcDIDYgjLSPdpBvalh6CZ08p1Od
         stl0I3yoV6XvIZE6h3PvBaQf1f341K8FQDIjuoZEgDYsGTCRvF73s+yug+MegJvmOi13
         2vbVEaGjTt29uWlNgBVPQxZGpJWmXZCmFHTHbJ/1g8nqmvox9IDu5FcJzXYJ1limCywG
         OrRg==
X-Gm-Message-State: AOJu0YxP4p08euRkSz2lVZNl8Cuts5VgBvhtHkWkApX76dyUFR8nZ2mq
	R6COTL5EI0x8N0srGfA/XVI7GzkcBzF3VkC7TdlxG1ixNGgruG96VnkTramIvQD4SpJkPZ4K//1
	awMPse6gw78Na4iED4UgqNOafYXIvpTI=
X-Gm-Gg: AZuq6aJ9V2i/hpdNapYS023SK2BD3CZeeAuESyYIb7N+SCWqCp52C19D70N74PEEfai
	3kjGnAGshASHtHO8eVERBDz/PbRgFoYI0S2Brl2PSVf1I0y2bvIT1KimGYBRI4VF+CWy8Qpf+pW
	UqpgreOqX2UuYGD4sWqFe868WYDRo3oUzqy0TYOULRwkZEXzwbant6WaIzY5Rniwx1pxh9xYLqG
	JQ7/VosNTw+uQsjfWK7LFDUjWZiBFnnzSviSvdvtBSgeXhz3M1eCIenfOp219rTzLaobU4XILij
	Hkz9gQjG2JASvx21hobIssd8ULTsmCO0rSvs2c0=
X-Received: by 2002:a05:6000:4381:b0:435:ad52:31d9 with SMTP id
 ffacd0b85a97d-435dd086069mr4693999f8f.28.1769559252547; Tue, 27 Jan 2026
 16:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127181610.86376-1-emil@etsalapatis.com> <20260127181610.86376-4-emil@etsalapatis.com>
In-Reply-To: <20260127181610.86376-4-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Jan 2026 01:13:35 +0100
X-Gm-Features: AZwV_Qh1Hez9xlkg31JfmXGFcF7d_KOZucTzffbUw51z_KrZTe8WtmVq_6htWfw
Message-ID: <CAP01T77GwHgS04TM8yTODyiXh2VJq-=L0FPoRvjpfF4dc6T9zw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] selftests: bpf: Move bpf_arena_spin_lock.h to
 the top level
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, etsal@meta.com, 
	ihor.solodrai@linux.dev, martin.lau@kernel.org, puranjay@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 19:16, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> The bpf_arena_spin_lock.h header is useful for all programs and not
> just the selftests. Move it to the top level of the BPF selftests
> to make it more readily accessible.

"Since this header will be used in multiple object files that may be
linked together, mark global variables and global functions as __weak
to avoid linker errors."

>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
