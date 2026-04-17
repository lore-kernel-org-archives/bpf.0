Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D53815FF
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436565; cv=none; b=V4fLNkJLVcFTzTnBBFuL8KUgd3hBGKrQD5AcR1Oc1opi0ZiJUWxSB5McdjSm57XJGFc43hJ90EYjGy5/JyuhWnAE2kGHl2Hbv11X+AHpWYTqvUwW8QyFW+ivGyBCnJRabueFH/MSMiy/DSq5yTUSN0MUrszb1GqonBQSJD1w1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436565; c=relaxed/simple;
	bh=SMlpHNEHwe3+8aVMcZOH/cMcsBOBVp8ceOoRxOvNmuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QTXauuuekNX7kzWl0zSucxmvuFgKoa/bfaTdGgUzNfi10WH9HyuxI84FVDqs5a2Z0ZD+qTfdt619YQ8jxKQuOfUmEijBdR2kZ4vt5VojBVHtuhS+rLRAwUtdm4LqnyN47FYf0+2jN+a0PPckbhYsDOC3wkVebONNMstMFW3yduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YzI+4CDs; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YzI+4CDs"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b299b3c739so3475425ad.3
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776436563; x=1777041363; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT7oKccX/4Ra6nk7H5tJfTyPY0n3/hbtp0e9Mh9TXGc=;
        b=YzI+4CDsK6OJz7AyBcqyTBTp4QMkZtCyX5NsZJ3mh7lkQBW2Zgtb7B7/ad3HH9ESkW
         ICCnAEjgF+Z0ISClTKTD69A/X5b1qI0YeB6388M9Gpo+zcUCOc4HMyyuMjWMyBqVlCuf
         GLkr3TH9DZxj2ohLDxo/C6OJQebTu3nkFFLent0tsj9T/Cz19bnieHY6oLaJJ+9chfFk
         a7W/dOnFMXrHEh4IxVVc772tJiudKKTsor0Yozwfq68L/MMw1ZoZ7qa2k1652sDjfpmX
         1xPay+efqgX27Aa8zDXrSyd5Hj7EK0mjBhJcB6zpHhzZeGaS+mjhVy04gATzBggTgJBu
         T8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776436563; x=1777041363;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GT7oKccX/4Ra6nk7H5tJfTyPY0n3/hbtp0e9Mh9TXGc=;
        b=ATzjb5cW4y5egDtcnqxae6cUNyPL2uSnFmOz6+tpBp/46Gm2+PmZp5SvtCYZ7cL2nO
         u0aqiXmqAEiGhwpyabaqVU1jlQZeWkOPvDauky5wu4Lv0HdjWJRGYFbM8MVaE5xVeIJ4
         WJeYaX+EzxUuEMWy/uM6uCdVs4nmv6D5FmO6tpI83XjTjlyRph+4iO9HQpFpZyghWrCo
         9ET5BjnZGhLyGC7Tvo0mO6cszC/fzUxztUUDzU1E826bVbbLldErhik3Ye/Sh4EEw3tt
         Hcia2YxLhrv6UFr6O5+1cl9QGk2ItKg8rh6sD6vyudEuYZ1/w9sqyfSZo1GNknnl2nCk
         wjsg==
X-Forwarded-Encrypted: i=1; AFNElJ+Hi0RForI6mwy7V9wKhBDzYF5pihck+2mpc59Zi7vzTE3lPJYCY5LJ9EPpfFg3Smjnt7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFu4vGEs0AeNs5khAaigJq3C6rmOa8pRpdjndjnhtfKXaAu3fL
	NqhINjBhcPnRbCDgodelPY9MkloCQqb65LwqbEKlJ3m6svpGsji84aIcW6dgHI7lfgQ=
X-Gm-Gg: AeBDiesvBmkhE9zG2FCzj15rRwRktMH2iXO8b5tzMzq62ZpLvARZ4AvyRYl5xYsXWtM
	FOdBlpy69lY0uR394f3w1LKtnTiw2Km0lu1oI/hWioyYbvZw9HK3x8hGowxMtp47Bwc3/kBkQhz
	Voy8R4MPlTKxfEIPfwKgK+ucOUCKnR2NPWZ9xbqjncEyrL2xazdYZMgISVMRmJEP3zCPMTu0VN3
	hHZm4ruZpbkq48okz4j+cV5RobCzAj/OI6oyCkvtrEBgVmIbx4fyLasFaiL7AXmfxK8juPF7cYK
	kzFfHcsORjaQzHFK23xQ9UhUCQ6CPOP0/DrvJFfuQs+PQ2XsU/mTBPwiemhuzgRjcBahLGDpajP
	bUxUb2XFKhZMgYpHDwa7n/cGXS0uzMB1Zy7O25DURc52gu2Kuir0u4pDopkp0bCdSCMK0x1pbPo
	dQ/4Lb37D2o3XzTjCiYw==
X-Received: by 2002:a17:903:4510:b0:2b2:a6a2:c8ca with SMTP id d9443c01a7336-2b5f9ed123cmr24875015ad.13.1776436563109;
        Fri, 17 Apr 2026 07:36:03 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4049bsm19789975ad.77.2026.04.17.07.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 07:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 10:36:02 -0400
Message-Id: <DHVI7EG7J01L.1NG5IYE7UUK8W@etsalapatis.com>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Matt Bobrowski" <mattbobrowski@google.com>, "Song Liu"
 <song@kernel.org>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <aeFFQL-bOTN5dg7V@google.com> <aeFHKUsf86jw1v9W@google.com>
 <CAPhsuW4nvpP6UJ0xO0yJ=FcAVOrWDX6ASvcp04kWQfYBx=72mA@mail.gmail.com>
 <aeHML12PVPizitny@google.com>
In-Reply-To: <aeHML12PVPizitny@google.com>

On Fri Apr 17, 2026 at 1:59 AM EDT, Matt Bobrowski wrote:
> On Thu, Apr 16, 2026 at 01:43:49PM -0700, Song Liu wrote:
>> On Thu, Apr 16, 2026 at 1:31=E2=80=AFPM Matt Bobrowski <mattbobrowski@go=
ogle.com> wrote:
>> [...]
>> > >
>> > > I haven't had an opportunity to go through this patch series just ye=
t,
>> > > but can I just say that it excites me considerably! I've been wantin=
g
>> > > to carve out some time to implement something exactly like this for =
a
>> > > very long time (since BPF arena maps were initially introduced) as I
>> > > think it's going to be incredibly valuable for BPF users moving
>> > > forward.
>> >

Thank you!

>> > I swear that I also saw a notification stating that this series was
>> > applied to bpf/bpf-next.git (master), but upon checking I only see
>> > that commit 4c5f21d4dfa ("selftests/bpf: Add tests for non-arena/arena
>> > operations") from the series was applied. What's going on there?
>>=20
>> Part of it was committed. From patchwork-bot:
>>=20
>> Here is the summary with links:
>>   - [bpf-next,v7,1/9] bpf: Allow instructions with arena source and
>> non-arena dest registers
>>     (no matching commit)
>>   - [bpf-next,v7,2/9] selftests/bpf: Add tests for non-arena/arena opera=
tions
>>     https://git.kernel.org/bpf/bpf-next/c/4c5f21d4dfa4
>>   - [bpf-next,v7,3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the t=
op level
>>     (no matching commit)
>>   - [bpf-next,v7,4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE macros
>> to bpf_experimental.h
>>     (no matching commit)
>>   - [bpf-next,v7,5/9] selftests/bpf: Add basic libarena scaffolding
>>     (no matching commit)
>>   - [bpf-next,v7,6/9] selftests/bpf: Add arena ASAN runtime to libarena
>>     (no matching commit)
>>   - [bpf-next,v7,7/9] selftests/bpf: Add ASAN support for libarena selft=
ests
>>     (no matching commit)
>>   - [bpf-next,v7,8/9] selftests/bpf: Add buddy allocator for libarena
>>     (no matching commit)
>>   - [bpf-next,v7,9/9] selftests/bpf: Add selftests for libarena buddy al=
locator
>>     (no matching commit)
>
> Ah, yeah, I realized only after I had sent out my email.

Yes, only patches 1-2 were applied. The rest of the series is
self-contained within the library itself so it should be compatible with
7.1 regardless of when it gets merged.
