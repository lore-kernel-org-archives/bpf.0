Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793387237;
	b=QX81wm9EI58oRoZ5Z1OfJuSOVNa1G5RGt6XwXoHoW8lDB3CUHkWdKgB6reHBvSyWcofn
	 fC1bvJqaTwRjL8WeV4NAsquA/uN4frGs9RrINiEzevlCpQw5Ot8uvcC8xbt+wPkRawHdb
	 X+o8GGzfPWwJ+7Bo5LNY/HVHB+gUjTPwPWNbBrZWjmJik/fQrg6F1MpqW7iY4UsyRK8kC
	 b9/AWA0KcNYwWaYjOQ+g8wUH6M8OZOUbtHXSlPPtnoKCGPwxwyQIHEsbw6UuxqvIGMwwc
	 LDDl0A160yu0wjtuNByLgmFBvERcK7IPAR/r+dMTGxGrzGfl7i2WRP3Fwqv7V0VTVFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=OCftNx47efIzs+YCBM+El8sBn0JBNPv/PH6FqnaTqa8=;
	b=ERe9O1LIQitWVEA6hp+izGStNlhiRoe8YiFfP8ElJyrlQyLHRVryURMtYx56wElBByju
	 exnS2i4PcXuBiZeDJRo2F+VM7BbwfAW7B91aL2bskB5IGi0nGB4lb8Mwk0z8jpjAOfnMg
	 YF3W3tMYRw4AXgbZO7bcpySSRJX1o772dxEllvGNGxPlpFPAXZHhx2CHWQWsqiOUinN3A
	 kDfTafk9/swbBUwHaWZFjsRkoulS+dz51LnxgHAm+9CJU1GMKGPqJnrMbs5pTaDNw32y6
	 56YCJgprJArh7H2krVauD+uier4ZgC/fiHLkU2E2AXtQwPoD/4CunlfQJf2DOhUyxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jG7RPOnJ;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F9606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 19:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jG7RPOnJ
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso767922f8f.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793387235; x=1793992035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCftNx47efIzs+YCBM+El8sBn0JBNPv/PH6FqnaTqa8=;
        b=jG7RPOnJKiyo3F6OohUf7Cl6JQWWLnKEi8fLxdzp2dHRi9EWa4x/KsravX1CCSg+KU
         YcGIpZvLfEZNxAg2F58Jx+YKGKkqtMBT7p/4f8SBiCaI1vHsE0GBTChTEjktYyWKnYc9
         KkX21fwordXlCuFabT8RZ2DNNhVaihpCywh9gyPkWytn92/353ezfJhImBVbSHb/6LfT
         qNrEgAQP4WbtxfurLl3gNVt+RojTgVmZZM/y5mk6ij7ANGunIRWC9fB3vlNZGmbHLNP+
         4E7tEJ6LqlqH5LnzTFnQM+3V625h+CoDdm9dw3K5hynoJMZRJQ1Mcs9PQguLvjzp6wEP
         93dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793387235; x=1793992035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OCftNx47efIzs+YCBM+El8sBn0JBNPv/PH6FqnaTqa8=;
        b=qRs5n34gkhaxsOAwG0JbLjBJxvpX6+u+mF0xR9/8XSj2YBIpgkcTHksKr6jRC9NLRb
         qtBjYuOCrnPfr+JB6chXXeMZQ2ofCrsZiphWdZUFED5vkyNvsn4nVHb91qCLICTcw3bS
         nMfNukBsD9ERQ/h+lGKEhEEEVM6LVWTuhZRyW6LsjAq65+hE5ZKoOxvogYB7tktMJemN
         sxAanCXY2/VhUNAIyo1gxUZHqG1Kfd+3Sv7QJeR0K+TvqYZZDwbOjjD9SP5rkBtIVM9O
         8vRekevyW4e6kSw22NeKynC/A+D9m092ZI9T38aPGN9QdTpSVP4m6GiCzowCB4cfP2//
         8/TA==
X-Gm-Message-State: AFq9FYJwTepC7xbMwFPKfJbQrF7GWGxtzxBTEsGB//+kS1dfNHmAX7Yo
	PyWuEun+nBm8kkNCTXR/AMMzQRMO0a8KahAx3E+rsrOMHTg9zYv3+i/C
X-Gm-Gg: AYBFou0vESMsyBhixAa9Ov9NuYw1GSdKdiPOzq/BGfzVyheUuWpVV7ogWCaYH+VqSSd
	RJhx1cbv4TuFAYl5KW6pMlZU1YFBIpnK5ykz+dIWAVPqE/Xhi4sl891FFjvvF9E6KKYrGY6ngDB
	a2eY3jS0oWlt63FZkQ4YPF/NayMlazRNyhdp/UOBmTKp1qEoi5jiykRIAqWbssjRz9mKDM+NT04
	yqb3azUam0QHpx9Pt2DpXp/at8DcHrnbzXb1HmsEgiXqurfDOE4x+rkMBZLI7LehhXf1RnQu0lF
	gtA8W+1HaQDRVIF7mtPB4X4Eywhi3NLL1Zq8xHfOtQrHv51jMmxsLNNyXKGhfV4h3v0TViGREeW
	0TvulUVRA4fTDzJ988l659QRdevmQ3PnSNWNjwEweWHcFrcBCurfwYAnw2EzeaqtPiCj1BWKEt7
	9PHYH3DMFnCNxkYTZPee/qau4AU9Kv/A8tBXyKxgOtMaU2mI8NL8yJVJmHo0bw8I9T3miKFI7io
	CZJcnQSg1jwDh5lkYh8MnkEyTOO3c+if9ZFr1WW5zySA76SZ/K5tboIcZSDb3Ja6XgiCwvCj5Ca
	hot6aXOK4G89z+funRWZC96jD0JRrEaffKD8XAh5HA4g0QAu
X-Received: by 2002:a05:6000:e89:b0:487:baa:aa6b with SMTP id ffacd0b85a97d-48e6e4fac5bmr6104063f8f.43.1793387235182;
        Fri, 30 Oct 2026 12:07:15 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:bc7:8550:45c5:9dc1:ecb:5d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm4813362f8f.49.2026.10.30.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:07:14 -0700 (PDT)
Date: Fri, 30 Oct 2026 20:07:12 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf] libbpf: Enforce program limit only for loaded
 programs
Message-ID: <auTq4Fhs8T-lO36-@gmail.com>
References: <20261030092248.7388-1-mahe.tardy@gmail.com>
 <CAEf4BzaUg_KPB+k14ntDTaqU-3hEUQ8o5E2hSeUkaw4xwFwi9A@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaUg_KPB+k14ntDTaqU-3hEUQ8o5E2hSeUkaw4xwFwi9A@mail.gmail.com>

On Fri, Oct 30, 2026 at 11:35:41AM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 30, 2026 at 2:23 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > As explained in commit '259172bb6514 ("libbpf: Fix gen_loader assumption
> > on number of programs.")', nr_progs which is obj->nr_programs at this
> > stage is including subprogs and autoload=false progs which are filtered
> > later during the generation.
> >
> > Quoting Alexei, previous patch 'aac5ba0a4d52 ("libbpf: Reject excessive
> 
> we had a rebase, git sha changed, updated it here and in Fixes below.
> because of that patchworks bot might not send confirmation, but this
> landed in bpf-next, thanks

Thanks Andrii, indeed I didn't know. Have a nice weekend!

