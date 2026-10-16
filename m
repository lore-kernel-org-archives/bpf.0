Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143B2D0629
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113475; cv=none; b=mUbCfYYGHrblAZ6LHzZ2LSRPnbLLW2VmrNFIA5mzmAwWSfV+22qt4hnlll5OM04Lu0GSR7Hn3P8kt1OInjLn+mqfhYowJf/+fCEXftqF7VKl6/D2w0OiBw4g8ptuWabOWe54NgOshLvoBAFSzjx+b3fxSyrO3QXZ1UkTZzwTuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113475; c=relaxed/simple;
	bh=HTt6kA7VVsoDKBYc1jc/s1HIK+1/iMH2JAm+yJWvVKM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gEb4ED6cnF3/BUZelLfor46zvDljhA5XmjRLmhS75NzM3KospWDlkbGaU1a8araK28fGK0VwfpAq87Bk0mHG1Rgazl1K485LQ3aORvb22skibafB0qOZ0bpp3Ll61sEq4FWa6o+TR+k8pwSPy8F2+i7tdDjmIKWj1ATc116FJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZywvJTMk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZywvJTMk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1393850a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113473; x=1792718273; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D0bTWZs0ngJ7K81uZIgwnI10T1QZnwoDyP8aPoOAmc4=;
        b=ZywvJTMkhyJ/yELqSuQPsgSYOn0T3a34Qea5StEH9yZIXqFlAl50uE2dX+8T5YBYGq
         lcuoiFZvOfEncWAy2jewrcBxHfwOtXSRieeJuLtpm5yQkZn41A2BiH6YTnMxXaYVyT1T
         xn7nme7mPZn3EPbur6ow7Ve/hPrQnlvl15d+lrhFEsHv7ZT35toURMKaaAxivwS7zht5
         DMO9NgeMOcTRvcGTVRrgv63ompqLSn6JaXnk4YvcnNpO0BUqltJtHqyO/7wk3+5Trhlo
         +gtKYsN4Y95n5pO7klshUAzzFvJsyzBogKIH44La7xhIc8Xta8eq66+HzYO3aEmyx8bZ
         TKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113473; x=1792718273;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0bTWZs0ngJ7K81uZIgwnI10T1QZnwoDyP8aPoOAmc4=;
        b=h9PgPjMHJwPaH1HBqgzSQwyw4G+qMS6WEB6RRUM4qhG/xnvSLdzSUQTBilmhrkRy8m
         83EjDF/0xacpwZyN3po20X8wneLabkHMfVafQk9SxU+j3JJwH5YVnkw9Xt4C0TdIDsne
         zdOSaMfrf8S3Zs7aMd219tDhmI9jJNRGKdRvnp2dNsU2uHcPmN/kS2fdxiBS6rBgNWLN
         QezsQmFsZ0n4NcFNvYBBSUIFdMrSjqWNMynLCfyVL/Hhel3e3jeYvF5qEOFtJhWqNyku
         7J43yqVR+kudNM7t+Upy5NpI9Og7EK18L6o4S9RUplAQ27XFYddhSvZDowOZgQlshNw8
         P97g==
X-Gm-Message-State: AFq9FYIbvEcbTA2hB3Bdje2lXIWGApWFLAazvW4qCn7T0RrTE4ZP2o4Z
	CfbaETMZNBM7Fjh5t820aGTyVCbEP06blaVDsQlcaV7mKTS0O6gJaMGk
X-Gm-Gg: AYBFou02bDF+D0GQlyJjcnAveXHtpHyoP732yg77pmN5k8FbfWXBqDkkgWsSUE3Zb0i
	7GEzlP7k52Q/08h4h7JJsruN5DbiT4xAIIUl+/oHDl0UrQQ+RBna/i/1IMNazTnRJN6AOPp7A6q
	pNuBVxF0D3MgBrvk8HkVH1zGO6TmBvkGWwe12qVdYTvgP2PGXILp7svqmNQGISHZZpElmVw/8tO
	vbg3UTwmc3a1eDrhBUOLbKIQiGMotv/E7gcFsbyEQjIPnWANmwPg24Q/vIbkmU6TJTqxQ06oH6Q
	FhEtv/WxruOmHOmzUxBpASx5lwmykpNlMolfJeh/6ckpsfstWvCY/NoiVkOqDCj3PvGqqKDXXmP
	a+B64XA+AFtd+zVagt3aGbpoZVVHLZjFbXANNzpoQZHkgmD678gefTCVMyUOlCc5gJBBGmI2DTM
	GheIdQi8QZ6wRZvljpLg/vCOInFbAJ33/OvyVEsTv7UEU0o1yNfNLilirZMo8GKw1NmBYpsbRAV
	hE/PtC5lAbjA70Pc/W97+lkWXdOsLcUZrevwBrntk8Y2D7zGfnEnSdc+6FRMpLe9na5AfSQquCd
	uVU=
X-Received: by 2002:a17:90a:d006:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ab3a2901c2mr15762475a91.6.1792113473612;
        Thu, 15 Oct 2026 18:17:53 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm6421002a91.13.2026.10.15.18.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 18:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 01:17:52 +0000
Message-Id: <DM5V7FPH07OV.1EVK2WX0LJFCO@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Cupertino Miranda" <cupertino.miranda@oracle.com>, "David Faust"
 <david.faust@oracle.com>, "Ian Rogers" <irogers@google.com>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, "Vineet Gupta"
 <vineet.gupta@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/8] bpftool: Apply __bpf_core_pai per
 record on BTF dump
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Quentin Monnet" <qmo@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
 <20261016000012.2232059-4-ihor.solodrai@linux.dev>
In-Reply-To: <20261016000012.2232059-4-ihor.solodrai@linux.dev>

On Fri Oct 16, 2026 at 12:00 AM UTC, Ihor Solodrai wrote:
> -	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> -	printf("#pragma clang attribute push (__attribute__((preserve_access_in=
dex)), apply_to =3D record)\n");
> +	printf("#ifndef __bpf_core_pai\n");
> +	printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(p=
reserve_access_index)\n");
> +	printf("#define __bpf_core_pai preserve_access_index\n");
> +	printf("#else\n");
> +	printf("#define __bpf_core_pai\n");
> +	printf("#endif\n");

in rust we're going with 'btf_relocatable' name
