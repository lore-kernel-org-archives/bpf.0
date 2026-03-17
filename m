Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F93328E3
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740785; cv=pass; b=pyLKvInOGjGM9Gp4QiNWXv5UrLQyIop3xetgopj5OpfsjmIDcNvbAx1oaHL7QxWyM3J5Qz2XQ9zh/rbWJ592lgttiJ2Fpxgi1x2otwFCkDHh138woQHuHR52GaV5vasVWM30VR0xYC+gwFsp0PzPLEDZGZTiFBZ80sTN2qeczto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740785; c=relaxed/simple;
	bh=6mPxwyxVMZjdq7e+56MNAvhtPr2vUXCzVpZTjP4gE3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb+eXrGfN2239oOymjkaEeldh9zXdr4Iux0TUbNkCib/HLTEngKEduMTBqTvzhtLeb5mkWMd0/QECiX3gmkU2SQl8YUtJe+6j0M6QTDQ0xnxKbkGjgt/0ODLYy/5mWOVmgMMDMzg2hgoOoBW7aF71MBAoWko2WJgq7iI2vLd75k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGXN90BH; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGXN90BH"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3992045f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 02:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773740782; cv=none;
        d=google.com; s=arc-20240605;
        b=bXJO9aUQWYzWk5kpaRUNUdlBh29jIadWvslY3mA5rwOU8tZnV6IgPOcoMx/iAjfHda
         AqYgWjxvSQEw2lQJONksKB25bXWcEZYpCCUdBBtupuZzkwV3408oR0Menxm+ybCHC7Sj
         EZSwDgZ2b6S+h0MNqYBI18OI5FoF3zQfdwiyv6gy4apDFNPsnSXnctt+GcT72xq3hp/W
         l8PsS7CERxS5Mh/lMTvKk6lLVce76qnz49VZjTp2uJ21/Xatz7wQpsOkw1rmA++MdgWf
         H0SivSZt68M0QYspLC1PL6rvBbDYZoX19DAeyOXe6upifHgpKH+4ZMuRTTnA8jyQrpxr
         dfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6mPxwyxVMZjdq7e+56MNAvhtPr2vUXCzVpZTjP4gE3M=;
        fh=1+ZZolzoiM1rhPmxWgWO7df9NAdABsYHuKG/kYzMHcc=;
        b=ixmkz5GUu/B3vcRe27RMdTtcGuYlPKPBOVDoLLtDqoQjB9vd27GAxCP1In+gRTTGW8
         YsaiYWJV+8KQfzkQdQIBz196qzkloveCHBnsHIEJJaUKUvErvOtt6mFBFxER3V/lxcJl
         y8uxMaxR1//hNypqis92HEJy1+nocQ5/s9UEXFRruBYUMInAbKlrtwGEg235bB/nWY5e
         0EsZl3Iv0gcHfvpPnyNN4OpHHNF6/iQX1xnP11W0LJE83EDErOwvq5XWxmymDIJJxLVy
         N2KG5umbY98xT30gw0Pv+aJklSIlDu3OL7CA1umUictD8ZW1uExpx2syqoi5sB9KqeIp
         6xeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740782; x=1774345582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPxwyxVMZjdq7e+56MNAvhtPr2vUXCzVpZTjP4gE3M=;
        b=XGXN90BHdgYxK7ETOgnfpztx86DBH98gY7skT1iDIzCcyDv6YbiN5kOnGJ6q6sJgK2
         XO9ZoSedylJfkTxfakc6QepeguHeiF0I1oeYhMdEFcU/TN/i9NwqLvJ+jhkcEyNA4r89
         hL51Gx0xxolHxgEWGOqbsIiTHUKME82zonLDsyXXfHK62aCfCs7FfagQeM35YOaZ0huN
         gdnICuWQap6gx/rF6u/kyP7h/nJvpp5iFobaNyFQ7ouGNf+yffMtWCGosRcofTxw0Qbc
         aKW583OCLA6Gz79+jbCl863NDeyjZFn+qYyrYeb/HRhDpv9d4LQoxLTZJXU35zgMyfXd
         ONJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740782; x=1774345582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mPxwyxVMZjdq7e+56MNAvhtPr2vUXCzVpZTjP4gE3M=;
        b=MxzyXJdoJHx7wJQsUl4ysYw9U5LufiHfHLRiutiOhZp01SW1dgE7gThEm0ZzJgoe8z
         JCZtWUhjExdJMJYG8vw3gPONf8hX3jPqGYPt4uZvzOxm+KsZKj1Vc32lQ/M/vpgG3wjm
         vDK6EvsFafg3zjUB9uVO93VOhOW1NdcvJGvAY1BMLN6Z+uyywvUtx4lZcMKX+mktoP0a
         XciF9s4FU3ftOFd5kpVC6ouBh3nPR9krpecFbS3Wb5haHWnlnbbbqvSQItUPfOh7bZIf
         3Ews6EG17ufE6iAZ9JoAGw+mgN4zSixTgYaGZm5QJVUdWzGDznE20FG+xRPQi+iN0upc
         FVtA==
X-Forwarded-Encrypted: i=1; AJvYcCXeBHz3BtPYx8DEpjhbyZb3SdQkj1XKQ+bwzQyDKHoGYbUgypTJX+d2oz7ejLdlkxPzWxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJqYFQacd2LK1LBfOhmDPXWHurO3nMZ5Sp5rDzVH/KERBN0aT
	PIAznvWcJQUPiw58MXLGPcZPpd3SKixy5p3azAHKQUWxPIIomHzFBeCj1kxkyGVIGpQPmzIuuvf
	p/w7Pp/Nm5Hmij20M5YrLUUiDG+7SPUI=
X-Gm-Gg: ATEYQzz1PwdamL0xE9IrFdXuxpLRcBk6240i4ytaqYBFm+GmTk6bBW4H3IVlI4aaQZQ
	uuduNqjNEZ1QMWEZeJLYp8/eIj+llDVFFzubwsOe3NTV6A+3Vo8VFH+4o9z/kHmZUNLS+nAKbei
	3/K62PHYeLYWdw9CNtLt85crLN0YJchpOd2Y8/1K5r0kE6MeTFnV+eQ18haJS5d1kUIaEY7EQzr
	CLcAFIVfykxT7uMEdE35qPqnWQdPxxNh9xrUfqIXE8qDiEEibk2g8AC6GjJE67THyRxp+k6xeAx
	LeiVfXfQ3YvVX7zU+60g095kniJPR/u7zUvFgkXi4fGXoD3XYdj7yaqCrIgRZo5Q8tKGLA==
X-Received: by 2002:a05:6000:2901:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43b47ee45a1mr8034418f8f.29.1773740781851; Tue, 17 Mar 2026
 02:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131341.1285427-1-mykyta.yatsenko5@gmail.com> <abkfGJw2F_Mwuuvf@computer>
In-Reply-To: <abkfGJw2F_Mwuuvf@computer>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 10:45:45 +0100
X-Gm-Features: AaiRm512-NcBGXksSJmh4jEmk0n-yPGuVDWaeH3X9j0hPVffBb8rPq_GSE01_g0
Message-ID: <CAP01T772PgHtgHBVDmXqgEA+Cfu-TKs4vJXFMch7D8-n8pfQHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix special fields mem leak for
 non-prealloc maps
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 10:30, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> Hey Mykyta! I saw that you haven't really come back to this in a while.
> Is it alright if I try to continue with the patch ? Since it's mostly minor changes
> that are left, I'll try to get it to pass CI and implement the reviews
> Puranjay gave. Is it alright if I submit a v3 ?
>

It was superseded by
https://lore.kernel.org/bpf/20260227224806.646888-1-memxor@gmail.com.
