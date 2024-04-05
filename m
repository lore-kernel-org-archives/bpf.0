Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741724B5B
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302228; cv=none; b=ChboEXlw2uFtZ99B8sIyGXAR+xDlcskZZ4OiJRcqadcQGJe1yHS2VzMgvmlkX/TbkXlORfgVI9tasA09TWnQNm1KFDpi88Nr8vl3sf3SFTv37rcyau5QjnYFpWo7i+hSMQWkqHQU11/tzz2ftZ1MGuPwTjCRlciKJlGiAYXEQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302228; c=relaxed/simple;
	bh=LVUUK/0F7vxiPcgjat/i3OrTXu7fhRfchd0xlz25TTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLNyOLhcWz/U8aqUo7f4krbn7kng//KTnvPXXgtZdczsRSvLcNF9MaOizMtp5kEsepA6Ffogqq6OCg0QMg8SEIYoD7JCuJPXa7Np8GuA1AFl80WTc37j7Ua0rQ8UMaps/sDgQpSQoEm5mWch9oh+Hur5rdWXk9UiBZEoMGPwyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2HVgYEL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2HVgYEL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1406214a12.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302226; x=1712907026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVajS9qRGpYuNbBOZchE/plaG9pO1zsKOk4mEeTTSbY=;
        b=l2HVgYELbt6tkb4VS3yRZ+DXM4GiWMhOYIoLTSYLAV6himZqs9S21DNTJY1/cEn6WX
         NjhsZm98rZb9fkc4XucN66TXvK9CaCG/wcNa1rwOp2UChUWBkgf2/Ci+pZhldonmG4UL
         HMLQbhJk8v13S/4riUv0XI4iP8uMFJ6ZcIr7Yld4Ton6p0hsQPUtVzNasZIZ8WI+Bho5
         tD+Raq5AgeClqwYhMf0blGjEZMQiM1jGaFIi/aLH//zROI5KKOgUafuHX7J7SES43wD/
         Ami9EdBDwoDA2DThrjvfPPz0VOHD25rpXknRjqGnCVTgYlxyUNkcDqDcPePIZh91nqff
         Pqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302226; x=1712907026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVajS9qRGpYuNbBOZchE/plaG9pO1zsKOk4mEeTTSbY=;
        b=nX9gJzOI5icF/qbV4kRG5uV8D8gf/dQzEM5pe3NkaL76dVhheL6tc43TzzpUPncV3l
         saOpiT1NYMzOYwUGpRXr/A9Hs/T+own/1r07ckyYRA6kqVejfghobAARiP0JuXICF6gy
         +Yuq8vK166bEeHbhopnYzhYU/mtaIXvQHcvCKagDKiI2AmiWBtVM9VMWVV9OjxlYHaWx
         CoQzD7BqGRN+HgyzJ/3U3Lt/FOJ5dDgYfykD0ZHsM/71mTWcQoYO57G46R1970buMocq
         PKzLxqXGitTYLBQWQNuTcCrOqrqksRLo4ZNJ1nmyPLVCEpxgDLhE7ghAuZb5ASaCwkc+
         ufdw==
X-Forwarded-Encrypted: i=1; AJvYcCVvf9Vx3JaQgpsu6jQb8aMB0DqCEC3F90aVxjy1w+eVrqOqQ1jcOahT/2qhqtWK2+bPrYmOJ53HrySzaMOK+naCbqav
X-Gm-Message-State: AOJu0YwTgsNzerVclHLIDQDmKkiu92owgRmlsx2G9aS4GW9IMFAUGc9k
	69gZGT3wiz0bx8JeniUSr4Ttst4CYrvlozI/DAGoI1V5fxcs80Fy
X-Google-Smtp-Source: AGHT+IFskfsV3dwpd/mf4bRIj7AZ4pTNlU8tOrSmUmYKEic4FcDdPiSIcjH4wOZZQ/WTHqYdxyzaNA==
X-Received: by 2002:a17:902:c94b:b0:1e0:999f:c9bf with SMTP id i11-20020a170902c94b00b001e0999fc9bfmr742809pla.47.1712302226006;
        Fri, 05 Apr 2024 00:30:26 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.87.83])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001e2881c8de5sm864156plg.82.2024.04.05.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:30:25 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <qmo@kernel.org>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v5] bpftool: Mount bpffs on provided dir instead of
 parent dir
Date: Fri, 05 Apr 2024 13:00:20 +0530
Message-ID: <2733143.mvXUDI8C0e@valdaarhun>
In-Reply-To: <7de85056-b15e-4c4a-a2f5-a450eaadfab1@kernel.org>
References:
 <20240404192219.52373-1-icegambit91@gmail.com>
 <7de85056-b15e-4c4a-a2f5-a450eaadfab1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Friday, April 5, 2024 4:02:14 AM IST Quentin Monnet wrote:
> [...]
> Tested-by: Quentin Monnet <qmo@kernel.org>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> 
> Thank you!

Thank you for the review!

Thanks,
Sahil


