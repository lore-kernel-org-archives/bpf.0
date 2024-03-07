Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8913340E
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842350; cv=none; b=pmFBB+KkkyNIubg9bTPImlsZir7F8Z+t5bEEqxSJepXR9MkrhD29B+EKegvHtCLjBtljdb1/4fACmq8gbnsOEfOSlXBHptWPpbDXeHYobly/XePgNQZ6sCvqIUvJ2IgVgOxUGbw90X9GM70uoBZhSo5MVfsjL/BPL1CSCM6GKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842350; c=relaxed/simple;
	bh=Lo2CNY3nKoduRLbgkjbEUUzQ9WFLvcWreiW+sSW55G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hul2b2c1214aUH7+qUqROi6lkFi2DDh53lc4W3PH/dxfPH1G53KHx3PqbHuwhZP7SoxdtJFrdlsRjXKtUTorljnXKMnHl8LPDG9750jRy+Jx25o2UuMFz9pgcGxrJFBWzjSPq824yC/wCwNO7pDx3sp2NGMaAX2NYw+qQQMm8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqnzqOfP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqnzqOfP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso1102205b3a.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709842348; x=1710447148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPoGVCBQ/hr8dqoXINKOTS2IHS+rgtryoabA2ks1WdY=;
        b=VqnzqOfP2Pn2e7Hy5okWlq6GrH9Q4FPsF/FJuVvPRaP0+ADbkGo8EEC6eG22mPycci
         95+0TWb6bGWAXxUicVlVu8cFyQwNaDmSvkhkW7u8DlZw67T5Qkee3UH1V8Ng6jdT0Y7C
         mwAOMn3P5qlAQJqTgS7EL2+qH3RzYD/0kBeHoVWR1t/E7i1p0waZNWkysBrQK2CzzBeR
         NeFLCGmbVHa3OG1bTcML8elWhoQjZB55+ga55wOdWijUwvelu+yTmOyjNT25w5LJaKOk
         Vj7RcS0fwSZOc1GhVenXy3chfapwiwdf3e9jnN257JseIUjIkkVzMDLihTkeyRXfg5Fi
         oeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842348; x=1710447148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPoGVCBQ/hr8dqoXINKOTS2IHS+rgtryoabA2ks1WdY=;
        b=rZgiysjXLp9SQ1qAxzBPHiK+cZM9Cr7WFWax73BiG/5M8C4SSlcj+4pt+emtudF3f+
         Pje8TJiJx9mobbddFaC+yJPDlu2Jn1ZakBR1CYHtkuJEzJDwuAw7JO+OjC40jmXaKH1a
         EAhFAcOmHfCwM+GWPC0rGhovf8/3O+F55DKVAdFaPZFmt3UNYO7agVGyug7xKhj2VPTW
         SIKt8L3V5kFrvD+yJiFV38Z3t9pxbwBcjwYVv1r+Pgd1UkAI8o4wQrj3rmm7IclHVEyO
         KqYpJF5PUxqzj1x9c0NbylzNhDKmUZtecC0gG/G70ZIto84rhb0ZcJ/jbenftlhI5pIv
         7SBw==
X-Forwarded-Encrypted: i=1; AJvYcCXHoJTOX/uCN8edcVqauWYS9gJeTw+KU7IXy7oVdsIiTadqne3kAGYDb8pgEuRiBIQOQaJVdlEuPYeu7gnuhIfyY0LO
X-Gm-Message-State: AOJu0YxrlEcIgBe0Fy/U7CftuBRmAiPdNrb1IIW5tPsY1Gsd0ZcI/L6j
	End3hRIcqaDePg9TfXMOL2gbQGbKB4Thfr0SRmcua/Um2I0cQ4uI
X-Google-Smtp-Source: AGHT+IGh0DJxvl36XkBei0VXJt/4JMQAjGpPc30igcamGIMpBxsdDtJ/KJYl3r7FYhADT2TMkPKuBQ==
X-Received: by 2002:a05:6a00:9295:b0:6e6:1c12:513c with SMTP id jw21-20020a056a00929500b006e61c12513cmr14009621pfb.34.1709842347861;
        Thu, 07 Mar 2024 12:12:27 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.80.64])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b006e583a649b4sm12920231pfn.210.2024.03.07.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:12:27 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of parent
 dir
Date: Fri, 08 Mar 2024 01:42:15 +0530
Message-ID: <4911236.31r3eYUQgx@valdaarhun>
In-Reply-To: <2f65b98c-a442-4316-884c-a877233edc60@isovalent.com>
References:
 <20240229130543.17491-1-icegambit91@gmail.com>
 <2347452.ElGaqSPkdT@valdaarhun>
 <2f65b98c-a442-4316-884c-a877233edc60@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Tuesday, March 5, 2024 4:05:32 PM IST Quentin Monnet wrote:
> [...]
> Yes, we should remove this second condition too for files. Running
> "is_bpffs(name)" makes no sense as we know we'll have an error at this
> point.
> 
> What we could do to improve the current code, however, is returning an
> error from mount_bpffs_for_pin() if the file exists, rather than
> mounting the bpffs and waiting for bpf_obj_pin() to return the error.
> This would prevent bpftool from mounting the bpffs when we already know
> the operation will fail.
> 
> Quentin

Sorry for the delay in replying. I have got a patch ready and have
incorporated this as well. I need to run a few tests and then I'll be
able to send a new patch.

Thanks,
Sahil


