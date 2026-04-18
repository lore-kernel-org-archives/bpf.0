Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EE222597
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776546459; cv=pass; b=dtylC2Yqe5dQeLFjm+jMsqSb65VTk1nrhJFBpNjrd3jzBUOUq/gV/e0jdybgJ+AY3NhwmEDzKtKXbl8ncFEccrZhj7rneGgtJi3gRinetvrGw4zUg6W7JEVGTQvYjpQH2ckKntUjf02lHnkM3X/rUwyH8usdUHW9dEYuiqbVsNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776546459; c=relaxed/simple;
	bh=7AhnyV6yj0D9O35DUurL1VuGjCruZ9kGYGfMybrWWVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+gwdkD8DMqAq1f7T6ENNQPWjFflOibgKeufbxndx3uRVQ5s+hvC7O5k0Aj6Eqrd3azEyc4P9nLVCKM9Zn8lqSLGBSF1G5TLSe9yCHXD5pLMVVt6sezs7A4UCLTv3gMSGCgKupl6AG9zvRQWJsjb+CKP/nXONVFUuighhTxJWdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1H3a7MH; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1H3a7MH"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so733998f8f.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 14:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776546456; cv=none;
        d=google.com; s=arc-20240605;
        b=VHNc/Iy/qk/xUR8R0EpxhulNNx99wcoHzpouuGKcTpUeAaTLmwgI/KeQgL9UYZNYlX
         OaHi17vnOzSEz//VPzYk3oqT6514iDVAmjGZrpfhb+AoVGIpq8dt9vhGApBxYrlas8Zy
         9795qUh5uHG2nGmh8cYvhrgegdbLtSsZOaQTDk8Br5gMKBZgzk2U8YBYEeHgTUXMxOau
         DaE9FMPhCIDjqXiPbxV/zNwWMQMf86EHLO2/p09ZgvzxK+LnDp2+2WIFLpkEwsB2cUzb
         pe2SafrK5Zu+Um9fRyxG5QIxlCw6ySixgs6LsQWvW+FPtVXRKR7P06KCp7IA3WrcHoXu
         SYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7AhnyV6yj0D9O35DUurL1VuGjCruZ9kGYGfMybrWWVA=;
        fh=fVSCX/56bobSX+daNMtZL+JDZZfcl7ZuKkc0nDHFH5g=;
        b=Xs+6ysBh8ZUWEkO6JRGGjzKLu71MaxDRdj6RwogqZgSt01wDr7BbM9xWQjj9IadwCT
         KC0myxTpCksvY92rnQcKd7EnC2GpO5RVCjylJYrowoHHToOCuJZzj0rxUyCebGk2pS2C
         LQvx3Sm2hWYWX8W0k95p5hbTi6B1LHVumEc1PK4hdYTWh8VmpNqK5aUQC5Q9+MXMArTT
         gI1byS3KNh+Q0kDlKeh3HrmT7ifyRvf9n1MHnhEsmiVriI1Gzhp2XBDl5fktOaV9div6
         bH4bZQ/WTAcUQFLAJxSX4stWxoY22gDijWeWloKZI1/pamlhZZ1J/QmYcS1hHOY/Ysyv
         pgkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776546456; x=1777151256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AhnyV6yj0D9O35DUurL1VuGjCruZ9kGYGfMybrWWVA=;
        b=O1H3a7MHwSJ+Z/JWq6w/U37I9aNcSjDAr7ScaOgxBYPu6aGK6nYMzuQG1M/EnAUZTa
         ES973ud7jZp0HRVezaaNH73hDCp3xYKm5VkpRWq8y3J7kEZayD5xFKC2rGipeXPnqyVe
         v2QQlZQn+O+dovbdmJf6SqEVSUE9YU0yTZPFx/QBVWlreuIhwOlkZqZtQ5D75agn6yl9
         74Yo7CvbzRpGbi0I3aNA1cpSOAUqcmgPmcbXC9K8cz/ZNJEuxf1/Te+OrJa04+Ry7H/e
         jY9oVIUGNMqptpGgY+qXLloTNWqLeurlJUDFS1gn8VDIb9mABjMEHPPUxzxrClWmDvTS
         Pjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776546456; x=1777151256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AhnyV6yj0D9O35DUurL1VuGjCruZ9kGYGfMybrWWVA=;
        b=WQB3fT17aZQ9H/wWReRRElCl0t/G41RQt4dhF+EiJoMJpCC/UFcES4oPjCJgr6pb3m
         OHO0fo5bIcPrVMQ8PlRMGAo/JO26iEQTQzCieAMiA1gQjc1qV+1WKppa7mSV5YXtt6q/
         PO93cr6XSkwDV+0wYq29vrt5yNSgqc464Nb20olWyNITBuDcNaV/9ZsAtnAqM5dkQc7K
         OjkIhtyu5H1YEOh8XczKdDqsW7jUjLMiZEof/FkoAc3qewXn6pFQ4KDCMluD5P6vTdAG
         /sTJWhaQBf8Lc8pMyq3aG5B5fjBtcCyScICBGl9YLvZPfh1gDy83NRFZ11lOYTjgVVzv
         v+SA==
X-Gm-Message-State: AOJu0YwYM6z/dGtmeLDabXDJUOQhZk27srrj9GY1sS4uVmCOEMBeBf2y
	boZ/p3zEPdzFLTdjMdgV/L2XVvKFOdDcdfRx17E/01BbEWA0yfIzFQ9Z9hMiuE+2slLzzT9JT+m
	KlKN+n6DI2X1o4JWvfUyL5214xpoYgQI=
X-Gm-Gg: AeBDieuba0XShmIfh3jC7LG6TZU/4BhbwmZUy2vwAroxV+spEIljJZnZEE2LkZGggue
	BwWpRBpqZshlvCnK8zV9y3BIm1lCpCpp0JxumFPBr7i3/7gWHHnd10mMIvt7gJ3ejra2uwdcAX8
	hytZZgQkJ3uFiuSkwZ8LSAneKILFjtjlNgAntjd5K4D+BD46aX6N/p3wHyfmWRg7q+dTfCbbWIB
	fhKayLo1CglZjuJU2qrDCFk0lCBdffXk6b+ZK8KuevG9UBU7gseULlIk08UuiXKkJPkOsUTCgS6
	TA2fcFU0OQ/VjxB1R75ucYhkoskKtFHf3m3FXzFDdNrV+kFpS2Kh04x6ylOA0sQOwPfejIKypvg
	lwA0oM3vj04q8urTd5R2WoWtnJQoN6+zNCsTcGYQA5bDptGbrd1Q=
X-Received: by 2002:a5d:64c4:0:b0:43d:7783:c67a with SMTP id
 ffacd0b85a97d-43fe3e14e05mr11354018f8f.44.1776546455882; Sat, 18 Apr 2026
 14:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417233631.1443199-1-ameryhung@gmail.com>
In-Reply-To: <20260417233631.1443199-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 22:06:57 +0100
X-Gm-Features: AQROBzD9pVXmosMuJhWfytJXARq0UQMHNdcEWWhmnmjL9-ceJyeh0LhKU1ifULA
Message-ID: <CAP01T75=4bpGvmyUjjkqPQ98RJm-YPfnVt5KFJfgce0t-An9GQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] selftests/bpf: Trace bpf_local_storage_update
 to debug flaky local storage tests
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Apr 2026 at 00:36, Amery Hung <ameryhung@gmail.com> wrote:
>
> task_local_storage/sys_enter_exit and cgrp_local_storage/
> cgroup_iter_sleepable occasionally fail in CI possibly because
> bpf_{task,cgrp}_storage_get() returns NULL. Add a fexit probe on
> bpf_local_storage_update() to capture the actual error code when this
> happens. It will allow us to tell if it is trylock failure in
> kmalloc_nolock(), timeout/deadlock in rqspinlock or something else.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

I assume this is to get signal on what goes wrong when we see a
failure next time?
LGTM though.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
