Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0B37FF42
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605393; cv=none; b=B+H97yJCCcOtguFm3WIc4zpqwtI7nMBwfRqwN3bpYNw3QleXN/rp25POg4vDnSNsXAB99NOnoLuuDe0jW+HszuhCs45z48kANooFajcFjSvUhCGprXDgyjhhvx85u+AEihTyh5Lpe/k3LpvZSgBKJsDHgnI6lPaPB3jipfZ6rqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605393; c=relaxed/simple;
	bh=Hp2QrPOWKqCv7nAk4ci0TLOs1jBx/SSiuHZVLojI+Co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxzmvI+Ys5PmuZ8gz29d+8l9QvM5k8fugrRS2mIRR2dcirpstUU5ze75yEWrNUdeLgEPlYTuqmsEQjDG1HQVc8Kw7szrAiyLBwpHu0FRmrV6NdVN+fTlE4fRHur2S7wPMhHmAMkDIOM2XbfpA1WyL+7KNuatJYLKIvWelah5TO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA7roWzM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA7roWzM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so1491826a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 22:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772605392; x=1773210192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9B/eoXPHzf4Ne438osq3GavHWtC0eEvRnIZrrT/wzs=;
        b=iA7roWzMkYyAkMGrHXcjq65NhpNDbVWNh7D+u0c9H68N5fG0C08OPApcIjBXJ6+Wwx
         hjQ+x3xmepHpgFPTm4mqk0UB+SbujcJjvDwjYXIYhrYZw5FbRjFufPHUvePGg+T8JKHj
         9oNrV5Gfe+pccKeF2fULUKTWEb7Rw5YWJPzQy6uWPzBx5rp8+HzqH84pR8Y4kRYp78Uf
         RQ24hxhxK9QW990ZG4oalCakUQmBLTJtTWXjTT2IhtBvMulYZ2Pmw+NM97S1pGiVTYb+
         iRC7NI24sYTIHrW4hSeQW27dhNnx5gsftp4r/WaO4c18Q1d96KrT24DebTBMT4IaV0Bq
         bJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772605392; x=1773210192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9B/eoXPHzf4Ne438osq3GavHWtC0eEvRnIZrrT/wzs=;
        b=B5ZMjekSRZaaRUw53K4AaE3dnkYBgy4j2mUe77xk36xM22deENzulriC8XUuk1fbVD
         clyLuZ4VyvAWTJNcYM8S5AmN7pijlNugOinZZiRoT3iVwjLM6EIwYyDQv4CM05no3lyd
         iwBMDreqokx30DnRUC2nBxgKgw2AGThvsGb0Xchv4xiYoocQlGCTyiewrWzcM7pYR6Hi
         5Du/xaPeDjuYHmOxpf7ErSkgXjA7TjS6PiHUYjwfdduP9R0TYUVQgartIBA5ElYLWt/0
         za9VQuAxErsKOtpEVSVnUrrGcQCkuAb8LA4v+ok3TjyO3ZJhguNGxGxy/NlZJaiSL2gO
         19+w==
X-Forwarded-Encrypted: i=1; AJvYcCVWt6Jzfmhj8Loc8YDF24BOAXxAmHehmWPWBAYFFtrlMyETtYOWlqjJpa1C9vydWIjXS30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXJPA5+9Uj/j+1IzfUT66kmV/aJNN0I2ua+5H6GbzHOLvSLsi
	e2+3HRwVsjEjFPGoO5PUr0qQfj5hJBO3VZxlk53nupMOPMatRpu2ntXB
X-Gm-Gg: ATEYQzxvMSEA3cbZiP3BqJU9lMKdCkycQW4ECMw84L7gvr0VKpBwq0VSh7H4eZP5300
	6LpuNJP1I/BD23e24l1vRZlqDO5r+NeBWZH63ZwGxIxtV5fl/7EXB90vF0cs2OZKpFhByB2cn+1
	DrswPqXBMbuYAjs8lhXDNMBOIyMSEBLbmiCVGI5rjZRG6rX2rvMyPfIWZPON3vPMuTSEx6DS2wB
	85m509R0Uxm4bj22suJVjQz7xNf6ZCZsx9Oiq/+8x/GndOa3BAERU6Z+gjAlWRC2gstfdDjU1Ot
	2c/3iiz2JqYPcZY1LMZO+sgL4haq5Fo+Zzg4YpbJK7jF2ro7hVaw64A2U/3VyXS7gf4Xk91FfB6
	TlHEBwtl2/E+tu/svIU/iDmOgV9KuZNDKpX94qgvE2k8SUoPgW0yyMC4sXBGFVja2SgnJdBoxFG
	7JLn9iRk8k1nlUmx4hx60YOWPrDmT3KekazCgFa2pyO4NUGPPuHKEf
X-Received: by 2002:a17:90b:2f87:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-3599ceb537dmr4072869a91.9.1772605392279;
        Tue, 03 Mar 2026 22:23:12 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54e394aasm96198375ad.77.2026.03.03.22.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:23:11 -0800 (PST)
Message-ID: <e50cb1e9f805d55a04cf0396aeb9fa3823a2f37b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf, x86: Emit ENDBR for indirect jump
 targets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>
Date: Tue, 03 Mar 2026 22:23:09 -0800
In-Reply-To: <20260302102726.1126019-5-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
	 <20260302102726.1126019-5-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 18:27 +0800, Xu Kuohai wrote:

[...]

> @@ -2449,7 +2452,7 @@ st:			if (is_imm8(insn->off))
> =20
>  			/* call */
>  		case BPF_JMP | BPF_CALL: {
> -			u8 *ip =3D image + addrs[i - 1];
> +			u8 *ip =3D image + addrs[i - 1] + (prog - temp);
                                                        ^^^^^^^^^^^^^
			Could you please comment a bit why this addend is needed?
> =20
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {

[...]
