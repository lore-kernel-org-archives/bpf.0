Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD04349BA
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544722; cv=none; b=AxxII0vkl3olry4/zf+XZ9l5Ct9GnT46dhZkbO23dD2sRG13aY4+5nVZ+vwnQTlalI4TYkwWgQIepByRXcVAOqsPGn2dWMLy35tN/+imYipdFc+DKmB5yprmTUNfF9Uy/HEHZH0SvboG/rZB2ZhV+LwIq4mi9zDQeu1fBYUuO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544722; c=relaxed/simple;
	bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwY/tAVdyQmretwyLMFVREH/6RJSUEgZgGdx5oYU9qJEq9QAehMYaWPIDNppy0RS5w/cDFyd4100RKx7+1dXQrI0N+E0xUFHp4uxsaDm8cp8wUSdazW+6RIRQVWjZjgyqY7vQ9XExEbdeLlXkwlBJZFHPe0xXjqM/jTn8VbvIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFm0Gq3W; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFm0Gq3W"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso394554a91.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789544713; x=1790149513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
        b=PFm0Gq3WrEM+XyHSM0m6jwbZXyXxeiLyT77s1WMuEe5N5/3crM/jaBQV1a1TrNHBsd
         F/ZxQ8dUxknTJ0TTku4HyJsyLf79nqLdxus6lNAoLNw+bB4qkMxDhDu3PSEmn9aAFHB8
         1TI0H5R6T6qCVdl2S48XCfEbh3AmtrwR6UO/AWMIuybjknFMumWosTF5p5Pm4j4k9iRE
         iiC6/IxzFECl54mtcLlU7GBrEogDOGttgAf4d0uNOK1yQjscrdJyjAh/gFyUa+eneOWe
         6M70qrZQSnp7XdH9UXz/4I6xb8vuOihnoYwpw2uMnDV9EUD56naoqxNiP0GJRAtw6zEL
         pJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789544713; x=1790149513;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+54NuxISumPJe/kOdveNbMQVvj3n/4w+75nBM9JTe54=;
        b=w7lZpC7BHa6jnMMiPgI14aSJsgjVLqT7MdOws+Qf87njBVTUAD8e1uxVnWYLierKki
         /Cx2YPQ9xrhm+9HUDZmTdDkaB2XGoJO3aLhkSm8cN3wwruHozIRvBFAR1CTImzJ8Uhm+
         wqXbK5iIJgk3p13vX4RrQNuBPqCR4bvOgxV0dma6hvPZyC3uoF50VMk3k3t80C/pXqB9
         /ST3ncdWna/AV77Jro1Tyaxq7Xgqzvu+fmotx2MQGIQ5FRGEhiXquMRMcO/e7Iwpx64U
         OD2EwhZMMWt9TAqzlYKyT+3jCm2KQxNj6dE+XT7rlnHp3HD9cKMNB5SgTrhnVO3oKejS
         th9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzerwmyFvD5d0BU0Fflui83aPNPi5L89yfY6oJdhLwtQ6Nlcb6oKcdro8QDVVNxxIMBmIc=@vger.kernel.org
X-Gm-Message-State: AFuF++l/iucFjVlReKFS7B0wQFlPodOMN5INp0zRUVX0Cj7ZmG3Cc1hG
	5mtm8TRwUFEtViECk9xPtqJsn9Gdf1mkEkgXvxE1mmSi3jzEcfQOjy20
X-Gm-Gg: AYBFou3ON4PEc5SUno/TQTMl4WQskBBie8QmUamjZj2v3v62MPGbojamzkai4EXqJQh
	rUlt9hzrkDbpsiEaRldjZ0UP2xuwOWozvVSdEdve7VE035O1hLYF1hAS9lXdEPwEPnfnBv+IAMx
	Wwj6fTOaKRs95WpIGZzVU9TwQCN+UZoDUlX3LVDJVoh+WtD2/ZgtY1gDwtWcdOAtNuWlEpu2brf
	62Jv64t2wcnlu1dh8DrFExe8lCmef/GGce3EemEag1ym77qEozTyuD7YmksLdsuuvy+HYggfkk2
	KkYSkADqDrt0pVnHvP4IKten9NFnQb1DtRZ1VeNmGB4S9dGRpmnsp12YwnD5ZMGVGuz6Z24B5E6
	J2nWFE6BXs1d4+7e0BshxAjka/YFOB/8BRz6Ig/x7ZHn7LLUtqd/8cTjWzRxUe3LDIdtG9UDTr6
	lG7u7AJGhS2NthHHyMRFjK7PgoJVo1MM9vW9JtqBFjSzrORgJPBq505CVNoVQH3aI5bAfpljwq+
	TBYmcRXk6UGVjcI/3Kebj+EN68=
X-Received: by 2002:a17:90a:d444:b0:39e:b0b:4d1a with SMTP id 98e67ed59e1d1-39e1e2e50eamr4358854a91.6.1789544712860;
        Wed, 16 Sep 2026 00:45:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1d0be48csm848785a91.3.2026.09.16.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:45:12 -0700 (PDT)
Message-ID: <cf7c21aa04b250d03500a855aac6f15f19eda816.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF
 types into split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
 martin.lau@linux.dev, 	memxor@gmail.com, emil@etsalapatis.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, 	tj@kernel.org, kees@kernel.org,
 bpf@vger.kernel.org, nathan@kernel.org, 	nsc@kernel.org, arnd@arndb.de,
 puranjay@kernel.org, yatsenko@meta.com, 	atenart@kernel.org,
 ojeda@kernel.org, linux-modules@vger.kernel.org
Date: Wed, 16 Sep 2026 00:45:09 -0700
In-Reply-To: <bd56c5cb-fe35-4ce6-91b1-d83fad7c422f@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
	 <20260901165757.801449-4-alan.maguire@oracle.com>
	 <98c9c5838b50871b3a138d2104450774268644b3.camel@gmail.com>
	 <bd56c5cb-fe35-4ce6-91b1-d83fad7c422f@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:33 +0100, Alan Maguire wrote:

...

> Thanks for doing this Eduard, it looks like a really neat solution! The p=
ermutation
> approach - which is really a permute and a segmentation - felt a bit clun=
ky and
> doesn't feel like it belongs in libbpf really (it's a very specific probl=
em).
>=20
> I'll play around with this a bit more, and with your permission maybe we =
could
> include it in the kbuild inline series? (I'm splitting up the work into t=
he
> libbpf/kernel location support needed for pahole, and a followup to add t=
he
> location info)

Hi Alan,

Glad to hear you find this code useful, please feel free to organize
and change it in any way you see fit. Looking forward to the v3.

Thanks,
Eduard
