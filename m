Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B844D5977
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644425; cv=none; b=NpcBBVD044JNKamSnrZitsnmECR+aX3bAhIL+K5kbDY/XszLZCsaafKL0JCwpfu19nLtNTqGATN6JdUd+2qwFwvZL37bPMc0n9PJJlgMbapiV9Qtt92AjTgjR03GWsyPfbZeo/Ab+UOxqd14XdFqGYjmytKMndkuAgUNKIxgjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644425; c=relaxed/simple;
	bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L+qUvGv+syDcyrFUeZIPGaEHM07mwsv6laL432DLgeNv/2utrYXGjbKouJQ/LpVRDr+cQCMfc+dymD868Z+1LoMawB+7z8ZUUr8y/fATcCmHGPSaInSPU7GAj/6d48tVnAUoZwXBtdXLpq6koRTMIt1L4Ow1OJ92VmuMetz+O5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4a1R3/a; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4a1R3/a"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so332006f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789644422; x=1790249222; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
        b=p4a1R3/a44085P/wLAXM889aehNxu6Q6YHRFlbV82l3cEMA0Rrcz1bsHcDAGQPhyxl
         ol99zdBsbGdghXYBnsjW1jQrVFhB8UX53Ai0qcfvO2iW8C4vVWE+20Fcx567hMT9DVVJ
         RfSD9oHjJvKlSznmkMKIGllovBfWEbEWQpwW7rp2NwWqpMNpCa4sv6wiaVBFi+z+9tCu
         DaJCJVWljQlAEcE1R3vzB1pLI07qD4pNtMyrC1ZYslHsRiVCuIZ9oWL8WTKsujCO1MRw
         uJcC1btV3ekp1KWbHMMNmhHrKNxIQ41PT9COLXpF1nllk/VAXbIF6qi5pZiUhf2dI9+n
         oZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644422; x=1790249222;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
        b=OnxR9OUD07LXXqkkDC5/+geQugBPvjMZQpYQZKX6NHsLtNILX62C2zzaEgYtCPyTr+
         Me3waAMNYyd0gTxgy1YPKCBnrr5M0k8jwQALYeaZa0ehsSBhpLM9t4lIWPX8kSZLqzKa
         4ixlt+72Cy66m1cAjm+TXQ1YqfDFbXyNcZBhjUaHB1LyxaqtC3miP/Psusvu29S5lXt/
         rlcOYXl6MuI1z46j/qZMsQqWdJY0P8UrOggdU9nNydcmkqt2mNrnUkjYWX++9LYhrerI
         xo/gnHww2slAoeeuW76GtrI1dRWWBAryYwWoT7I4PJyBpeSoZtCP8XjZsqTNcKQvXyVy
         lsqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzacIxWzeXWIQ5wRsIlddI3sQeiHviAnextwEIsyV3998v0xDONMf8wYIoIsyhECoBTvo8=@vger.kernel.org
X-Gm-Message-State: AFuF++nUTvlB0oxYbqtf74VxOCLZDWtBqTl+INmvNGIJh8Qp/94EvOlb
	IFhRCDNXRuwyL+atG+COGyjZp5jt25nvWcbqgr+TTOcrGrZ4APqgW40n
X-Gm-Gg: AYBFou1J6XLU84PY4eXgJYrcN8+RS6tRqdq0M8W6HPZZ4X5egQ3TjaOL3b4Q1i0FNe7
	86tmOZHeIP5AsH0MyO/D0Nk7dyp3O4j4qm/6RS4CywK9LiY/8D6gFC4VlLBRigo4OhU/WNUfDSZ
	2O8sigGLPLcEe6yT37Zb3SxYKWUn0iWpyDHUozGqcuQPV+9tDXosM/TJuPlhuW/N03kuvpbVJEZ
	bozgbknLMA4CzUo+fXNIxO0GiARPclTv15pt3F4lKTKd8gEqnhMD90MTIEV/c9DT6YIeMrxeWV0
	DpV+0ia0MWck3EB3NguPouiV+6La6j8HMK6wZFA6uDddwM5q8K8/h0tGMMl6n/Gm2SEBBQsEPVl
	+OzzCOchQvpRB4zQ9qcmy+223bd75iBUxahY7JRrVEccFWXQucikfNO/QehAxzWSZlJfMenNHlF
	Da/MfmpgovCQu9x17D7kQeorEjg46+4BQoPiLUzKSiwWYEUsRJ1Cy9wD6uyCZvH6WAzWu14ldqh
	9uuBppTZCriQd+ZaGhs5Vu9XbwVdphZDYtezB632PuyeccrO3rY2AUVB9Vy+Zk9SbZUwJEG5zyD
	7vAIj/iMla7IN96I7y0yKqJPvf8iPOhXR4qUEw==
X-Received: by 2002:a05:6000:27cd:b0:487:d8f:27a0 with SMTP id ffacd0b85a97d-4870d8f282amr5317777f8f.32.1789644421948;
        Thu, 17 Sep 2026 04:27:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fe7esm15118417f8f.6.2026.09.17.04.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:27:01 +0200
Message-Id: <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-next@vger.kernel.org>
Subject: Re: Missing signoff in the bpf tree
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
In-Reply-To: <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>

On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 01:20:11PM +0200, Kumar Kartikeya Dwivedi wrote:
>> On Thu Sep 17, 2026 at 1:09 PM CEST, Mark Brown wrote:
>
>> > Does the contacts list for the BPF trees need to be updated?
>
>> Well, he's the committer, so makes sense to put him in the recipients as=
 well :).
>> Once he gets to this he can probably force push to correct it, I guess.
>
> Do you have a full list of the current committers, I guess there's been
> more bitrot than just this?

It's me and Eduard, apart from Alexei, Daniel, and Andrii.
