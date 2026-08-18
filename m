Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6D448B86
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046569; cv=none; b=qz7MQ2eO2oNrg2PgsAbr19MzLv+xsUsaB9cNQKk3vgtBaDpgf+yIFEjtDF005Y3rgxLLUh7CrLmAihV5IaYTikwy/0YbLFdHaU0arAP/2GpNWHyBHj0tPcM3r7DtPCAhOizMLysq/kcd5HyOsFtD+ZUygZSSGbon3B2SanZzGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046569; c=relaxed/simple;
	bh=x+hUVSpLmnGOBRbrUs8t/YAarM8tfurNyZaOcnSMAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDPSVb+kASbWMYDv//5jXQH1QggSHAt61POVyt2lZnEkfbUlyXT4L0A3qCkYvBtJcFQSUYRxjrWKWFWxmqz1ZmgmTCQwZO3xhK9GXKoc8bYnQohHmlsFKtFXUF9RUNj7gTR897Am8JSb9C9G++PefDq2MYK81zC3/ifM16xyyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig3oTXHF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig3oTXHF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a2c90e383so633886b3a.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046568; x=1787651368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVZqfaL1cDu6QLngalu7WE4kGe47MKpcY+uRtreSbGM=;
        b=Ig3oTXHFnuk+O/rPOeaLzDl+jyEagcFcJxOiOmB8kHgos0tZrh4g+TCVtc+BWfHDLo
         wKZcM/K98SvKWpkUJ1gOa/cV/Ud5X/2/AKieyZdkoXVzepfiN/VaJVeKvJqrmcQnygXT
         abSB1bsAT6kgsBmvKUaiSX+lSS2boh31n5tzXR7i6xId4s8kbPJd4U/ggD1EKlM51XD7
         xBuA+6LAxr90IWswayf0RPGRgo+HSPmZGhq3bMUJ4zu8sMFsED+9p/ZAZPJdejNN04om
         o8OzNA3Pjm45VRjM676u98/+6fsnR5grzG0DusVMkdr3brrz1uxFLNCOuMT43ipJP1Zi
         4XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046568; x=1787651368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NVZqfaL1cDu6QLngalu7WE4kGe47MKpcY+uRtreSbGM=;
        b=tErtCENyArOVeMT4GfFzoad4j5bE4uSxhn6s7WtYsb2QqBrVV7rEYHgmnciWAe2u6S
         r+Rh54cmHI8B0apa7+sBltj2c3wssWELfy8igOBRCTTGwmlAUz4+2MNe2jEn//2ouLnF
         r0jYv+yWraJlR56OAbXYz53ovCZdcmKFw0328aGQU4b8ZaIGXiuNar02pyu2T3sMWFNw
         FfPaK2VqbvnGCwY3RCnb6vavxaofBEvTx4URv34W28sOsdiAWR02xu/HbNfTR245dNr1
         UKP9LLpdbMj8GVssLZPoAxzFaIHy0NsKXzE8ojXgcKHF1SJYZjNV1hVDAgzGXa/fWe66
         gsJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpn5Won0jVysNaazm0uQuUIb1fe/pH8wONd+KK7wscbcQmjeqzaP9iTdqeM7FyW6Yyjn+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbU1ziASywYmUAWAKMIocEuXzb8CTBOKg9fKTalBdbFwDGLd6
	DJbVVcoDHwNpFsGHtinSofBPglxva72QHhDzAzO9Fm17vWFqvrhflLw2
X-Gm-Gg: AR+sD11bdQ5b1WH2Lct/JhEo3bIlHKuFg11yBzHqIHhU5hzn2UHm5Tq+N1QsGiLg6Dl
	59Sf3WoUtJFmvV7gMICctNa503nxC+1zGkrkvHm5l94guWHTtuVtayjGhC0TrExz4LXPI+Ks5SP
	vyWxb10nGBM0swRccuhyvgiyEq0W6powDTgYUc1crclDNg9/FTvSlbLfLuUgXTnu5GY4W5hdKF0
	/xLGnURUJ5VC2b521NBVj8mvloJMDG2RsFB2JxdAKWjakVB9IlwkB+AmqZFyx1oJsPFGotbWZqH
	YxmNQeSpA6bRhSqWEXON4Y7as4gwmggXyX9esb8S8sdW3KcP3Ggz/+haEg6wPp+VZKoyyPYGANm
	G9FSOu4sKcc7+DRuyFiQ4JTRJ72LdBDw7xoieQtVxG+ynLDiVAHKTNXQ0uBPDm4mK3jt5JiFiHc
	E6x9IQTd0WNE0RTOgPRw3Y9i9HPGT4+T9ze23+NA1WkVuvZnjBz/fUUPgADbocvu/VwwqQJ3zZI
	c92Hy11FKj5gtsIKtSxj+5h5GjO5jZhF08o2/Fnw12H22JK4zGJ
X-Received: by 2002:a05:6a00:10cf:b0:847:9dd7:2683 with SMTP id d2e1a72fcca58-851bc380e98mr4882490b3a.9.1787046567622;
        Tue, 18 Aug 2026 02:49:27 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6f8b057sm1310191b3a.29.2026.08.18.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:49:26 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Tue, 18 Aug 2026 18:48:51 +0900
Message-ID: <20260818094851.2941245-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <c065e1e3-7d78-4098-901d-7cf257f3ce0e@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Leon,

Thanks for the review.

> Seems not a good choice to use 'bool check_cap_net_admin' here.
>
> Better to factor out a helper to check CAP_NET_ADMIN first?

I tried to minimize the code changes and avoid introducing another helper, but
it seems that your approach is cleaner than this version. 

Let me try that way in v3, thanks!
