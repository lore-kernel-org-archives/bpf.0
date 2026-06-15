Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FC3AB272
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553718; cv=none; b=BNgIWFxmqBXNHlP5NhygSfwcrVhdVWlCWYdNdYIF4YWKRL9iCJwAmN/lAvzSZMt51z/+0al4KOVhlJva9EqlwXWxgPvww86PM3AD9jz4jfawbC87ZokryqjWN6jvqEIEJTv6S4G+iaq8RvhJABh8QzzFIhAghJwc7aYq9P37yoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553718; c=relaxed/simple;
	bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=utrl9XEhz352DS6jEAkMFRyavQ8NAo25lslq7Dr1EX1KKjs3uiPLxKXYJkTxLbebg9tqJ4MK4tSo5/gjPSXCdiIFgX09PVHsw3bRGPWeTmvOcqvIibABSh0JQwpdyxTxrntW7mFKRCRCkqXiYzl7Wz+u7nVes2pggBuvE75dAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REfJrHTI; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REfJrHTI"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6f922e49fso2908398a34.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553717; x=1782158517; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=REfJrHTInBiVRv//3tKuAYZhJuYowOkkjM7C3kh11hlWYd4enPG0QSLMve9dcPQl20
         1xkE9nXQdVpbSiBGFdVXpCplJLS3fJwruL4KirS07InOJz87vrOE6mKjRvW/gtF6E68A
         58MIbcEIkz8Gr+55aFBJR+i7F8teH5DfAOSQZF+ZHa4TmjCpxd6GEudrmMsa9df3Ugar
         3iRoVQzSF/feot0dP9/SfdL61WX0XKDeHvshKzJ4cpXMVLJLViXRGVXwcD0xOP7TiM2S
         dwHQktxyNOM1G6FDtkzri9wNQ9zVBya/IrCzW8fVoHfWrhC9dMBtiE3TWa8xC7GypRJV
         x8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553717; x=1782158517;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=EtcOYbVm2REeWDcpNkdRWiIFTr3iRCuePTUbIBD0yPV6xI2jVz/oVxfc8SHaeF7VLX
         jbBrM1mEoGoxUMKizr4b9EtyD3ooqM6bRA64l73a0YDVtVe0x1/p3wfWqOK27BWmAuQ/
         2keqvqdzKAHrFCzFFvtdLhnS/2rQuq0d+NSTE4jUzo3OjzwhvLmMRAfntIBf2NcqYL3+
         Pb7/XpWdmhaGu4meoK6tedLybuQHBJOXdsuTqfFp5eV5N5wpRXcAGVs8do11aHQZfmFp
         5bpW//pzZtHWzcrfdstmNQ99PrnDzYNxu+XtwvYkbab9sOW1Gb5C4TK8h+XEh2dGBBA9
         X17g==
X-Forwarded-Encrypted: i=1; AFNElJ8g6cnTQE9qaH51NQFHvskAYvjGxbmKe/D10DyOEXWA44SjBuKQSSTdjfcgmmWe7ChPa7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfECfbuVHN1emqEGk3Tt2bU0bzzKJPZX2Y93TaRT9jqcYEvSL
	IcG6PhtCIsP54yj73yT7jubqGUC063ckI/5pouDPalRY9OUuVC9TATs/
X-Gm-Gg: Acq92OHNZ2jWUTj6k6gidVL//rP8bsA5N+g558G7KUp8KfZPs+lV+zwrtB0Tkusf1ah
	1MWUuqiZy/WVyDLCH3Q3Am8dasj6YTSjZi1j/dfawJfByXq3DBZBOiPo4ar7dZ+7ezRkDjBDZt9
	lsP0q3dAo8NaZPHpm2ZGqX5O3dxe2k1lCmUlayr5rp0rpmFzrJdObgZp3cv59l0PoRKRFJq9X4t
	FEtX3lCXRRaMg9K61yOlC2cJNCdvSGlDBgkmmnPpydHOSf4AdjFhj055HnmCm8LSTrHs/nRseyE
	VP6GfBF1RdGXZSzunkUuodz32F8rfLTC9bDcRaiJAlktQ/BX0ukkbc0oPRqWWaG6qxFneIv+y3k
	8zMCxu1uG9D+A0eJ5a15FlN3JCEbzbbIQQsaSfsgUlyXYBs3cLA+02G2kneeDkyjs3uqojm+Dz+
	9ezjB5MIDmE66JB81AR3a4ta2htxzqrIlxy7hwchBzaau4ZqwouehjgqZZ72wp1CZN69dymhKfW
	BEtRvHm9u6g5bUUKjn+0vUYBuc=
X-Received: by 2002:a05:6830:d11:b0:7e6:d542:aa with SMTP id 46e09a7af769-7e8fc512f82mr716552a34.23.1781553716566;
        Mon, 15 Jun 2026 13:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6b8624sm4773335a34.16.2026.06.15.13.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:01:54 -0700
Message-Id: <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI
> context. However, creating a HW perf event fails when there is no
> hardware PMU, or when running in a virtualized environment without a
> virtual PMU configured.
>
> Since tests are often performed in virtualized environments, fall back
> to a SW perf event so that the test can still run, even if it cannot
> cover IRQ-disabled sections.

Frankly, I wouldn't bother with this fallback, since it completely misses
irq disabled section which is the one to test with *_nolock().
VMs need to configured properly. Even nested VMs support
PERF_COUNT_HW_CPU_CYCLES.

Also in overflow_handler_test_nolock()
I would add
even->hw.interrupts =3D 0;
to the end to make sure it actually stress tests things.
Without it NMIs are not firing quickly enough.

