Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037C1E98EF
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745135; cv=none; b=jVg1dRodrcPjaVV0GUGdziYK6jDA2iHjRnI9j+LRmqwMSw3S+5DYEGeV8nu8+hlAPIeWxUEctQhAwnZ3JTUqf/RiQCTkj2gGkMR+fl4XH6Vc5SEpMphLyJLjihoP1Esm5Q+eaTB17jzTzOTxaCiS5+i9iJSjKdgojr3wTfbktLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745135; c=relaxed/simple;
	bh=Rcc/NX5FEJFOxRXZ9DDTD7xInDmsvLTzC5w5eWduUkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJfoWXLVlxU2LroL2AvVAV/7M6i4FDZd+UXG8esvUcuJID/HIQqWuDBJREIKVfPUzPJ4lwPkJraGF2aNs74u8ArzluoPuivVdauyOEKPvtM2WVfUIX5u4CGwWR1ihQR2aKc90ASY4xO14IAww+/rwxdHg7zJEzKlHbWdX7qJj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAcq3q5L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAcq3q5L"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6d28aa26cso17141685ad.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788745134; x=1789349934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rcc/NX5FEJFOxRXZ9DDTD7xInDmsvLTzC5w5eWduUkk=;
        b=rAcq3q5LGpkv0Pl5cMfV8+G8mepihWjJKUBCY7IADKf41AzoHkCjhSb5ilbxbPkXKX
         KA/ZCN9pUY9ilGmzvDGmS2aNx5Bldm2u5nVERQLVyi3fRsynU71UcgamIu4448dav0Mi
         6YweFLcS1cJ178hzrTgIlbr6EPaaryM9QAPbjLX+jolrDP5jUiSqYMHADzqxb26y8eVH
         JpBHWtJuw7INLx9G7zDNHYZQRTJvLZPR3UvuxVG0t6f2CL0jL+5wi66K6no5rRC9kEsM
         KFrH9x/Ui8cuxqOIoigvGjODhHP2zA8GO+zgOPRmJB55KFVhA1R67vQLN3cCyYYFWG6d
         yj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788745134; x=1789349934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rcc/NX5FEJFOxRXZ9DDTD7xInDmsvLTzC5w5eWduUkk=;
        b=WEwE6LXmho6bSuIISL5VKW5mcdSxva54Js9U3HVQYYW7WYgZsUF8zQcPb0EQlxRMXM
         fFabwr7x2DT3J2yena7CuxFP7ZP5YvBIOibOB2u1aUtRxoNs9e9HqwS4OJx3ANTKN5Gd
         Sa4SEaj4BZ8mt5TeFw/NRDQ/H78DEOsoK4P7HclPAa61bXOMqpt8kNapXBODDe8x3koC
         Gkkwas76Nu0+WN+30AugmkFFojTopoEM9gI9HKlm+odXWzGlF9fdIW3jA1XF2mZnF41D
         fyk5Oq+ZcM7puouHfJ0TW+W2HOrdbT3+FK5kKlJJfqrzsw79UEgVPV5vxK5ECiHQPoxJ
         LsdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYv/UvoQkfXvBCa/dBd6s79jwCXKHstv1uUVBlBig771EsOscXusjanF6w/5oFT5kSOJw=@vger.kernel.org
X-Gm-Message-State: AFuF++mqtdlNmCUbWBQxo99GmaFMbdKJseA04ajOH5Je50uNVul7VvF8
	I+afRBFlwWY3XU7s3TJuggD3fu1nAfIaCE99ixXfF2fzLnwcMrtAiiDE
X-Gm-Gg: AYBFou30g038lpHVQSCtBZFk9dmB0I0I7wP+qLlKBC4f4dBO/jAo1m24GCiFUhE2vOE
	wVRlXhfB3uPtYA2qc/DJg9DqTohV9xJLZTHV0NUbk8hjD9FSTLgZQrg65QCAONfwo7kWhW921mf
	EYsIh3yiA8s5yk323y+jwzKFD/BN3Y237VIU+/XxrYP+/Z/98Lo74Hh5spOvmsLDtYe0QnchoVS
	14z7gP0cD/Kx7OmD5wJA3BNvvOQ3Wmkm0GluZ/pvoehBpLQYG1ls9Qe79eVPA9wFLkThUxWSuQ3
	i2ehSDuOUs7XMvlhWqpR4mChgS9qMa7VTXOYyY5+9VCTbwe6OO61XybNqgSDf7Fmu1HOJjmQJ7A
	9V/w7dLtNJ5o96vMxDAl2bSSDAHtPW9yt4Q56g7jaxBbJ/uAPBd98dlnA+jdItdNpPRxRTwE+UD
	PMdMsYgHsMQ3yYEes+s8NnRTEoXithkOq4h3lVLiaFj6AkiOpst4aCxcC/kW5OsnsE+g9oxqoyg
	rsSOJNDKiMHpMQdFt8C5WG91EVPn8SXloY46HpuJ02GeZOW7uy1
X-Received: by 2002:a17:902:b114:b0:2d9:1dee:43e3 with SMTP id d9443c01a7336-2db12757f17mr188382005ad.18.1788745133792;
        Sun, 06 Sep 2026 18:38:53 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14996a3asm36305435ad.46.2026.09.06.18.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 18:38:52 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover attach type checks in link update
Date: Mon,  7 Sep 2026 10:38:19 +0900
Message-ID: <20260907013818.51624-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CABFh=a6YEtiZdcC51LXbZKTKWoXxCk9PSe5jtn1R-w_EWT4aUQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Emil,

Thanks for reviewing both patches. I'll come up with v6 with the things resolved.
