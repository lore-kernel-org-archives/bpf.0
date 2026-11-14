Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794648456;
	b=spRW7qQpV7eAS4y1iXJlaPVRe9J9YjTXPU/1zGqU8ENW6Bm0JOWwdKFir84fp4LGpEj8
	 xP/fb0DG/obRBjZ0QRNLEVetwwhhl0+6fX81gAeLBKU0/hRtFp84WItE3eIC69leHRLqz
	 mfP2I5rKF6On16iPwmpGMap2iphAhL9n+SoxdIFnNK+S7B9PLKfhNlbNIulTGL0jQj3xb
	 E+hnJxQB7/Qr21s1gbCMVm4RknOoraoTFvBN63xmQWaUIxRWJmGVIHFnXJ0JjqKJIUF15
	 nLI+O66lKxm0G1QSXeYdDV4XJsb76h2E0OeqzGqtlEWco45VHJrdwElhJS5BhwDpnBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
	b=5LkLdshDIHjfn8PIJPfkKFdhlah1Z5NwU5gzUMAbjcwlSbTzmJOV47VMiVD3gUdVHr8X
	 8R6GSOHuzq1YZY4RypJCUlLkYulqWnlLIVMR6F4aD51cHgTRKHp7SktdFcU2lKj1wkUQb
	 ZecrZHPXHnspEGXpVT7X+SgG1tugCWqfll8D3FBib7e2HEC9XREgljBAdNPwJsdOwoH0g
	 LHS4knGL+eN7xZU1wKb4ZVKFAkqnw30kLIXjeMCJHIgzSI7cNfQbHWaQ/wz4MSPgFtAou
	 0C+jxQgxWuWPz4khkLm4EPyiXXBUGVxWl8J/e9Sd/YeR1RtA47gGa85wRZuslIxH5HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5KoJgFd;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB601606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 09:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB601606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5KoJgFd
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb5f49a61bso3038785e9.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 01:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794648454; x=1795253254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
        b=N5KoJgFdxbvutLCBYOTB6R6ZTP3aEUY28rDtGlIBC0bus6G/FW07ChZpcDTCaZ6KwO
         AOQFdqxzCWiXE++cG/h+Msh7cNLIrH6FmJhmeWn4IbFVX13PbykYbqubnJwauBxeNvVp
         R56/W8xpxsRYrwpWjMediDdWJFJoMRzVsXYgxAshtggdDCyxhdfhzyqWohsI0WGdKxIC
         1N7WKSaLs5i/syvZdDXVSCuS+EgEIcDpRjxC03WdUuCWngHFbpTG3XX1BOt2/dl3TWRD
         Q/cjq+tYLQPGgZApIJYnbCQ6jOBG9Kk+hdpyugC8uYzxJI4sowM2yK5YADlEgLgOIEyN
         VfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648454; x=1795253254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYfseqkO7OC6/oxcEmE8wFTp9WLs906rRXW1lcqa5cA=;
        b=aIG7vKkO3D/WqA5HO2ybiYf+Wshv4spQlQQn6qjw8EjsUsE6aX9hQRZpYS3JhM983i
         i60z2DSOqgGIFguYLMfopUYPCHWrtryg1R5+y58d3eO/2ZPRQDYQJ29Y4wCrFb5c9/pq
         bwxywTf0wMIPKfspvWEbz0jJeexCVhLVqH1t0U3281Za7ugDjTBdn5Q3WPW4jojeZxel
         pTPKAq4W83Z8elFTW0L8/1rwTRRtjHPPWAfCOMJyO2Y5Gytrqywqs7oAhM/I12iutJ8p
         OXP4s8dbAN/e25GcSaQ/fTAn5FF1rTETAXaOmWuXqwo3NFayso92cenHWflYpFqVmtrT
         2SPA==
X-Forwarded-Encrypted: i=1; AL+hErHHPZTBj9KycN/iHBwJEZ4V5rSA53QJX2QBuc9Co7H7pYgg4zAo+vxzzzDwFhWy5WZgMlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HvNu8mJ9UZRwfFpQDFkPwOf5M64pLMzTU6V5INqqDcarmwZ6j
	ZQUhJaBRzHnfddbYdMQx4HHCCiX0z6SwHWkeZo2v5bFKXljoQMR7Lnmb
X-Gm-Gg: AYBFou3kk13fm1o3ESiSvvfp1vV9vK1vEoBbBNQd1s2UegMGUcO4pwdi3KXeHJb2gWQ
	mEP2Xj86xbWpe7DiWYR7SaBkFDVF9jNwcxphMuT1Whe+my7rpIpV/2Ra12E4yh++z8t4Kvy467D
	sWaiadf23HwzDrOZnDnFp6jWvmRmhAdqnyaxMJqRzQ2+4b1I2Efq9OA9g4DyEx9rOs3ahUnLmYM
	XnNOxFDR2OkudLzWTAEY6Q2dUC8AQ56XqZubyQOwcIFfwTNZVWrkxkMwPDuLhSe/dg7m1w9E/5X
	KGLu1T1sfbCIfcGVGg0tSXZuvzUjbWnMkU6Z5WOTKICJyBHtbBU3oYrT+FpPZgF8yQGMQGmobDk
	vIzel+h/na/BJsDr0T4ZuBQneV30xVJ2cEtWaNHEsdNGh18zsTd0QQp6ueS0dXt77A3vMLqfPa8
	gw7h8YbtaAYrx/D57AA0l5m5IaM/kyKIN2hsVZ2tDaREqAThEBMwBc/Sr/IPXEJkv2FJlWVv5JB
	2gm93PCATJtT9s1Ie5mfBNFqAUKNiLNaZ1sHaHpT+oYwxNScQiVkfBopNUmOZal+Gz9agOcc16a
	XkzEgT+OetNExv33QhAewI0N5DGksvSWyUFGEdnstA50vuCOZe+7+pp7RtDjQ08ZdBv0qPSPvoF
	yameHlTnXDiYTSYRNhymlMTeItTBvobLfWqGslM+SBNpUiSg02XW9bV3S3Xi0pS1peZMyShVsZZ
	mAcDNnKUPk1H6nM9puFQuflajbntQiXMdv/tvp7Zkr2tPxiZbel4wSvHg=
X-Received: by 2002:a05:600c:3b2a:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb55aabdf9mr108908365e9.25.1794648454037;
        Sat, 14 Nov 2026 01:27:34 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b358-dd01-fd08-0f0c-fef7-8409.310.pool.telefonica.de. [2a02:3100:b358:dd01:fd08:f0c:fef7:8409])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm62372995e9.4.2026.11.14.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:27:33 -0800 (PST)
Date: Sat, 14 Nov 2026 10:27:32 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Hari Bathini <hbathini@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>, Dan Carpenter <error27@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc32/bpf: return false from
 bpf_jit_supports_fsession() on ppc32
Message-ID: <avgpYvt_Gf_1obem@gmail.com>
References: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003184226.76740-1-kmehltretter@gmail.com>

On Sat, Oct 03, 2026 at 08:42:26PM +0100, Karl Mehltretter wrote:
> bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
> ("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
> ppc32 until fsession is validated there. The negative value converts to
> true, so the verifier does not reject fsession programs on ppc32. Such a
> program loads, and only attaching it fails because
> __arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.
> 
> Return false instead. The load then fails with "JIT does not support
> fsession". Tested with a ppc32 kernel on QEMU g3beige.
> 
> Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/

A friendly ping on this ppc32 BPF fsession fix. Patchwork on netdevbpf
marks it awaiting-upstream for the powerpc tree. Is anything else needed
from my side?

Thanks,
Karl
