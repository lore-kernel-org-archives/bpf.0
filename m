Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C029BD91
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789952268; cv=none; b=YOOky7TNdeTCbvRQ1vRgTqVxSyFfAihJC7WUk+dtpJjBsScxw7cCQMAvMHW7nCivqfPBiI1llifejG9nYwHYcVoBSCmciKBGAJvB3sKJWJxKyzEPChitKBiFpKZ5jRPhBy+XaJY7iivuwrjyCOa29R46foUX+Fav0ORRv/oliW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789952268; c=relaxed/simple;
	bh=C60AjUAEpXim1Lx1Qg54EvmPDrGaeVF56MRd17p2Mhg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=DM1J6ETk1BzZEbLQVM1DdguM2oN7LrrCIb+za2NssajlKXjB4H7ymLTZh4JfZpq8QWMF0k25x/NGBATLUp7wMVuDOaYLtOM71p8c9WAc/89P60seXOFFQergGoxJ5GziWysXbpnYHS3ac2Q96GXZGPVo31OOFJuV/e01Xxbuha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGx/2mpm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGx/2mpm"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1626745a91.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789952267; x=1790557067; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roGaqM7NVQofKofPOYKwFYhGCB8RP3HE83QmkgW8dwo=;
        b=tGx/2mpm6DLNIb89ROHoLk1IHMN817JS9Cmppow7JhJ/TXF8uCICn8fCp/iFYhPvAW
         p8u4Vv9Qm7dLb2+6SxkEf6pxZeHRpjv96iKkyUh/pRlLbeEmJGEeRnXza4/l14JuYeoa
         y8WomtMS/vUj37OVPaaU+0otbvNd1kyxOY1NPgPoz5/mFrfohNGAV4u0Wo7TctVfmi0P
         0T/dhuNCdc9vb9UKD2e6TOypaP9J2OkFqpk22eRdGZZbSkVFYK1pc06LTY+M2+DHAkad
         CAk4vOHDPldzE8xJoNkb93VozLsTgvB6L9DbEGpz5yDp2oFdNPdIoE57dgndKJk7r8pm
         0J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789952267; x=1790557067;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roGaqM7NVQofKofPOYKwFYhGCB8RP3HE83QmkgW8dwo=;
        b=iVhjnHQyWC3rnlMx9rlxabnAc/0gjK6g7f1Db/8nn7kZGyFg/8dbp4oyhoy63OcT6F
         PiDN64zr2mq28BWly6Y9LcjBRIlQLVEopGvJ2WoKEakE7jbzk4OhrFGi1qDvrc2RI73/
         ezYdBhtwIt/h1dfONFOQfzqjaFwpJ4r2nj+rAloZEN4JSYNW+YFFcnegKBBlZbCgpXRU
         PQQ07jgEx8M8ZCWzp4d3y8J1yrBvqBSTWWKkLZ4IJoxlNAxP9qc7LR8ybdf8hWBB78Qw
         XYv+1YsZ2KjJ2NLS2nRKS8dYWJ7hplK7kYprNs4fZDuxdDDPtMDrzHYh2GrOIG59V+R6
         gK0A==
X-Gm-Message-State: AFuF++mSA6Ive/sKKPfPWqEwTjj30AjYMOtypv1KyoYr/VFjacbOpqnI
	v5Vhw4iU2vPGj5xCtvBQUq1Vwz0RSPvsp/YN9h9RsvcHVX5Rf/8aeM/B
X-Gm-Gg: AYBFou0Ibw9vC3Ixa/l7WmF1oxCXg85cv0luScbVKaY0MRuxvgmPE/bp7AWZNoNMEsq
	D3/YRZdcxNeyyapneWRf7bz6JoZkwq+oTlBRULfWQLM1XVwadIZCLqUFF0WJXRL6bVmrwjpfIDd
	AHaJsivgwXKbXwFfgWvWfvLBh0R2rxXIokufyCgOaSRxERO5rI+3aABYfVq01IWqhnpwR3cI+z7
	5h7Z9Xd7hMvwBxpHExJtt28qiku4SV7cCRKouVEcxgCd3oyRS2X6D61OFND2l3WiJ2crsqFG0K8
	LfxUi4WzTUPHu2iEY+P01KHts2YOkR8ghudofXNQ2DSMSLEW44XUMgcfa30pX+i9kL8n8mkxFVJ
	ueKvbTW9z//gfiHJRTnsy53knwZI/uDc9FyoFDynUzg89+X6eP/Wqd8/D+sT+x+bwHEXKaiG/+h
	1J642oK0vNsdBGdBzJ0y2xoaXuYSUtHUEPPrpAslxG8QTVuczdtjY77FOeuW8w1OGv4HqbfBPlW
	Sz4AZN7MSFicfULpEFwAzcuBboFfhmXc8JEqHjIy6DfDLBums6+JSg91UHf+vxqK19nfTkNW9d1
	8dw=
X-Received: by 2002:a17:90b:56c5:b0:39e:4c81:6c66 with SMTP id 98e67ed59e1d1-39e54dc1a3emr14850525a91.33.1789952266591;
        Sun, 20 Sep 2026 17:57:46 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm11280817a91.11.2026.09.20.17.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 17:57:46 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 00:57:45 +0000
Message-Id: <DLKL4EZY63IU.V6E077SCBT1S@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260921002206.184660-3-tjmercier@google.com>
References: <20260921002206.184660-1-tjmercier@google.com> <20260921002206.184660-3-tjmercier@google.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 20, 2026 at 05:22 PM T.J. Mercier <tjmercier@google.com> wrote:
> +	l = __lookup_elem_raw(htab, head, hash, key, key_size, &n);
> +	if (l) {
> +		/*
> +		 * Pairs with smp_wmb() in alloc_htab_elem() to ensure
> +		 * value/pptr reads happen after key/hash match on
> +		 * recycled elements.
> +		 */
> +		smp_rmb();
> +		return l;
> +	}

Is this AI suggestion to add barriers?
I think it should be on the program side.
If users really care then they will add such barriers.
Doing it unconditionally will cost performance for everyone.
Especially on arm64.

If you disagree, please provide ./bench bpf-hashmap-lookup numbers on arm64
to demonstrate that perf is the same.

pw-bot: cr
