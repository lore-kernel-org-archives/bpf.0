Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9349A3D6
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644019; cv=none; b=l57uuIrZTTQHAKu7cR9P3kVacuNkxdpdAsEFpdS1W7OwPttXoGFf6Kra13CNd8rYnPS+L/TBnx1iNGWL66D9tTCtTTHcOjyFyT6lSkt5dPaNHb8OtczjK7WidZ4zddJ/jDuI3nvxyKePqeKZ3r5F0T+MlOcFMGCfK4FPIVZ21Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644019; c=relaxed/simple;
	bh=LlxGdMXHAdX8taCMIhqIXD7uLIJKX+ph9Ruyy3ooAaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hyRgSycjIOMSeMjlOLuK9uUIxz6JEFLb12qk6fkw6XW1gkk9ur7IxrumlHgoLW9DRBv6lVtXVk6+BYrAG/6kqIkxOZwIj4HThzp7qi9g8E1icVjhT9e/4k2eH7hsNa8xZ0MbWye13l3DNr45ykj50gcV5i1qA21m0r1lR1QJy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujon/4u9; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujon/4u9"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-486e4e15deaso200395f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789644012; x=1790248812; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+g+yvkGeEUlWNyJpsteUjFqXg2BUoy498hjd0wgzrh4=;
        b=Ujon/4u93dRla03uTYoS2izgIrqQkjHxlou7MTB/wEAzr+IzPSODRlWF2nWRYoKb+m
         fOgZbYgYv/oPcAy0mzvyti63Fm2nehNlvrXH6QT4w6d0ozwKAqto+SJQCPSHkOtWwZXP
         W6W3UMO+OxZG8MdLwNmokiL7mJZrJihJU7yL8mQT0WVc/UELvxRduWNXQQtEyG8ATpyC
         oQ/nmG3lBkjrL4RdMtvIjnM6eKvus1otUnPmJWldGLAPtDhD4/vEND4KK3Cgsx4IJcIe
         rArFOHE3zZVRZuuVtxXuW6uc5ZJinTFrMkAFa8JR4Qu55PlPVXogGWKPK75nJuITGTay
         RaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644012; x=1790248812;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+g+yvkGeEUlWNyJpsteUjFqXg2BUoy498hjd0wgzrh4=;
        b=RwaLA3+wBu1R8ifv3Zc86hvTHGIMbdG1geIRetJvzS+fInF5TIeXW8SBHbi8ijspI/
         73yCU1ncC0ULGUb9T4XFQerSgHR90XFbBO7+gTizrx0nmB2ZEJyzjvblrJmxcqyeUnNg
         UBKerHtDgfkxg8Kwm1bTsDvgTDkIGcCH9geNw6Vso6UQDpbUg+5duP4FVmjZQtRaOyJa
         IOVyPrH2YYsFouyh0QX3Cs4hfoEh7MHN65WBujeDsz0iQ+y38yZw6f0evLwm/nmK5RkX
         7UVhzK00Oc0y3mY7nyju0erD2REUUS/oO6m9YvfxNX+/nucYUgdM1y/+N+TlR+oei549
         6AzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyLcxmkloarXm9f/AkHr3s/Wqxhi5grlTR+44SArlxA7Z9+63zQ7tEJ5DesCar7KYy3FA=@vger.kernel.org
X-Gm-Message-State: AFuF++k/IJQWnRy7zk+WHj8y0q+QBHIO2XmrEdKf60xiN/UV7ghjo21R
	W7ce/yINLSR+pJSu4R7n4hMNpg56b9YEzyBI2aReTC2lC3ao5KrnMrfo
X-Gm-Gg: AYBFou1PsZfFTdwFPDni17q57OZKOLnKcFM5dSkV306B1mxJioS5Jd3xLJZsYWb3uBm
	lu0znGz94lsOoNUsuH5OZ/cbVKJgkXHatSPRMb4cg+H/2Q7ABavPRxzgIg99UopTSzuB39qsbWo
	5qFl0U0wTCdSewqArFO4OrA+EXtF6BHawbzc1zvH22InRKBx9M1/YkPGg4l7lNiE8Fc2G1ywuwR
	n669Zciw0rYOwU8ienXp1f3QX3v1TSi5yZP6nDxiPRUtptDTVk++Ny6GEyADyRRjptZRRTj1BaU
	Jut0BIJLc6wAAe22wTU9siV57tvKcVJCBI2/GOoDmq7rtZAIB5xO8YlO4xXWAMCzRHJViVfdJEa
	/ctCrF7UM04So8NG+6GZQQjw3ioAzqCyCJueXwuDalQUHtjSrQFlr4OB0oTbkeMcmQqmwaHrgSt
	Jo1PZsF4TtMy65IxTHYsU2z5YFzNSx16TRs+Ibti2DDAvjThyrWdqHvBehJcjIJICMEs5dvSP8w
	mc9mfwbbKoNJkukd+nYJqQCnZOryhPsBtTPQBPGt9YTUXXo0XJ5qiJOI/6gtRkJu2fyufdIjuSV
	WAxqD873Xl1d3jod1KEk4gKvLPOpSstdrGoc0zY=
X-Received: by 2002:a05:600c:620d:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49eac46430amr164310975e9.2.1789644012140;
        Thu, 17 Sep 2026 04:20:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm80589305e9.8.2026.09.17.04.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:20:11 +0200
Message-Id: <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
Subject: Re: Missing signoff in the bpf tree
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-next@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
In-Reply-To: <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>

On Thu Sep 17, 2026 at 1:09 PM CEST, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 12:59:30PM +0200, Kumar Kartikeya Dwivedi wrote:
>> +To Eduard
>>
>> On Thu Sep 17, 2026 at 12:30 PM CEST, Mark Brown wrote:
>> > Commits
>> >
>> >   4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts=
")
>> >   3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability con=
text")
>> >
>> > are missing a Signed-off-by from their committers
>
> Does the contacts list for the BPF trees need to be updated?

Well, he's the committer, so makes sense to put him in the recipients as we=
ll :).
Once he gets to this he can probably force push to correct it, I guess.
