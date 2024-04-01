Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD053BE
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711945667; cv=none; b=ShdffyLKZIrOQpeYJQmHI8GEsuXtx6uf01YGgrGrIg5nio9d7OyJNrkf2QejREqY7HLGezPNtAeDyT5mbG3WasZZLytUfa4vZ2lv+Kn5GR2/ABVBmJ70NW5WyuRP7T5wd5eqNgJONu6kOpl+7lZgPKqYyQ2b0ycmkLAR+Mz4hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711945667; c=relaxed/simple;
	bh=i0yY9Hi3gFNKU9HOBAqFXUBhOWlh+2pPEqeHSekwGOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBArz2my6SRsdmbqryzsHRVviHTksdY+V+Eqv0gu7Z8FoPjSaAddFcJXB/GGVBiRmhp7ey5b9r5g/7IaptjXj2xtOGEhXk9D09od6nK4K+iMXzpwR5hejIArm6s6P74CoDDvXoc2Yvw46GZ/aZj/bj2vmcqHxktfDO278GrhQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZXa7n0r; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZXa7n0r"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1888413a12.3
        for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711945665; x=1712550465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0yY9Hi3gFNKU9HOBAqFXUBhOWlh+2pPEqeHSekwGOU=;
        b=EZXa7n0r439CsZ3C7JHLRyIRA2o7gkfIQOHKZYq+xltGJ1qjvvsQhY+SPRasRSjkSI
         MSQGHBuAq++GjmrGpS9VIWcspGYUjzuL9tkU+iZSr9SGnwtXVewGSVsmtne8kq3ME6+u
         71oOjbjWKENHFYnLWTeBj3UfgPVVy1mcOi2fbXJqpyN2F5+rkM1Zs04sDCsivZASYdVb
         Y+ugUEVUItncRtKiBbsWXj0rurH8ABhbyxhYgAqBk+93hey7/YBZqYR2mnXJXZkrPfVI
         qlqv9aXGHOVDiOnxVrANNW9y7wgM1hPMW7JM6SR044I6hs735EzV5xM9ShbL8qjvz8At
         94vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711945665; x=1712550465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0yY9Hi3gFNKU9HOBAqFXUBhOWlh+2pPEqeHSekwGOU=;
        b=u8yGK9YbLUKzx/3dzMVbvY8kR6jSYPtKfVaFoy5+I15pLEjsr46bASdd5d8jTB+t89
         JRj+NjIHuEe70xoiLUdxr8W0KtTUI0ggLICv9NG5BP4/YqqFG8DJ88W4OK6uYAgJ7LbE
         /h86N1aXJ7AxoFLVh3EpG06sy8OR7O+fT1Sv0MqzwCWc88FYiH+Kb1Bmo6RdoDc6IfZ4
         HMVk9d6K9D3HlOBdXVZ8dihSzRDUZSkGORePceNkyK2/G79N7ncUrtX6ipec+k2oTyss
         d57EShfyxN6rGMr0a9M3E+0KZgWe/vdEr26TqaiUnpBp9twa1OIrPo3tPY6hlktk3Sdd
         Cx+A==
X-Forwarded-Encrypted: i=1; AJvYcCUE7LZPpoz8GSFJB7EHC3zZkOlxxPMDZAnxY+GQThXjm3FLILsjQmT3aW/REVgrEo/h33fsZng5V+4M9zSuPcjU+615
X-Gm-Message-State: AOJu0YxGnZ1GIYZBfOqlvUfLgo4SVT+B2DWSITi1odJjgXWRf1AdNEbJ
	hNHB/7f81jSiROGcZyZDFzOgDu2+VUwUENcegqAh6H6xEkRNsufK
X-Google-Smtp-Source: AGHT+IHy0+/fBSNRUFdqODkuOp4q7EC/Ow1PuZDTkYJT37CZTRS2csNOIrrUNY9xAsLx55tLJrshzg==
X-Received: by 2002:a05:6a20:394d:b0:1a3:647b:b895 with SMTP id r13-20020a056a20394d00b001a3647bb895mr8194770pzg.47.1711945665493;
        Sun, 31 Mar 2024 21:27:45 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.153])
        by smtp.gmail.com with ESMTPSA id lo14-20020a170903434e00b001e0aded0ca7sm7743530plb.239.2024.03.31.21.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 21:27:45 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <qmo@kernel.org>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v3] bpftool: Mount bpffs on provided dir instead of
 parent dir
Date: Mon, 01 Apr 2024 09:57:38 +0530
Message-ID: <4913334.31r3eYUQgx@valdaarhun>
In-Reply-To: <dfcab867-0b5d-4d3c-aeb0-43633b571196@kernel.org>
References:
 <20240321191955.24992-1-icegambit91@gmail.com>
 <dfcab867-0b5d-4d3c-aeb0-43633b571196@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Thank you for the review. I have refactored the error messages. I have
removed a few more parantheses.

On Wednesday, March 27, 2024 6:44:52 AM IST Quentin Monnet wrote:
> [...]
> We're already on an error path, I'd maybe drop the check on the return
> value from rmdir(). It doesn't matter much if it fails, I think.

I was thinking that if we fail to mount but manage to create the dir
successfully, then we should also clean up that new dir and send a
notification if we fail to remove that dir so the user can manually
remove it.

I guess it's ok to remove that error message though since dealing with
the "fail to mount" error will anyway require manual intervention.

> [...]
> This function must be renamed, as you did at the call sites.

Sorry, I must have forgotten to copy this when copying the changes
from the bpftool repo to my local bpf-next tree.

Thanks,
Sahil


