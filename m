Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5437EFFF
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588962; cv=none; b=V/QkAa83qANcVJk/4+xgZEUwLtm2BdZkPM2lLH6orTHC3Spt6JwRisjPC8Ppz08tAqD787jskaYm3mHqua9KFmO15u9QgD+yH5XX7iCnPErKAXKn85KYicf5kM+NE0uAn6xrArOrlAxj5WuzbWIPYahyYs9pe9SABGHZAGKtZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588962; c=relaxed/simple;
	bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mqtDwmLQooAIHpAbpqsrm0F7iXwV+YIkSF/zVX+vj2HNzCMMP4oOHxaSB8+YLqqChMmPFfOZEARyQxpkYrrS7O/qyQBLf6BWLjpxoHPIiqbMBVmsluxVYncBGwl2qrcSMtSNzzBAN7R+AysiBJowhUAqOLkB2PwpxE8511StibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kL+MbbYd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kL+MbbYd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bc85eda6b6so13820045ad.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778588950; x=1779193750; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
        b=kL+MbbYdUoipXk+/kkGNJwR3Z5BP5hBA3Ag88Oh3AWc73QBLyo5fGGKrC1VoRkMZKR
         ofIOVkU0dXQ069a/3XIpzX/EHHGbsLAmMliU2qqqRlrprSfqNLJsiHwNvLiO4IvababF
         Iiw7RRwyg4vCcHe4COPNPi1/78p05m+PZqVvBw+FKf8q5Z+I0kCAAkWJVZGP+CS9ekAW
         uwWzH4l5JqGq4xicQGZwAT1Fe/WH61cAbSTGu/8Rzx0HT6ZjZ9Xi8TrA1hwD/3gnThjT
         +RRzMlv0+aeS7PRiVJoOyRbXPtuOwBDx80xmsestrUXe7hLT8jxUReXMXuPNGHaGq4wE
         TvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778588950; x=1779193750;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umVNWktZmfkRdQrYKl483CR+VTehRJFRdPI74iAAm9M=;
        b=Bab6of4NNKZK33yTBsodmefuKUyhbGl72qP3xHiilDk2XlAAEaUocD5aL5MjXEEt5t
         26BQrJ4fRjLv0BVJeJmd8fehdqLHF/0gA9RPhIaMB6mNyctVlcaHZvI7iAkgIkoieMEd
         FrnKhQXKCVxbNBsGb0YD3KbLB9sHDAw9M32R4rQuxylD5iUIrhg0d9+DDUSL+kaulfLr
         DknLPKqIZ8qEvOAoEHSwTDP6dEyPeg6NYeObQkQJ9OyGlZU5CUtGyPcckZR80CK/ozUV
         rEFOp6VrLNJl8rk4k0PCeD16nKxrTCW05yMhhacx1jNKe748QZNyrrwSZuKFUBqHcUGY
         WA1A==
X-Forwarded-Encrypted: i=1; AFNElJ8tEaZBNNZw7aU3OUnGxXcdH4J49xZZHMFX82cyiRzJaOoZpbpF+REdg+nvo4aC2suVUKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxquwb/jIAMbHo+SDnOU2NIJ9hszU18Faztp/swhsZl8iAuyZUA
	nkmXLSaJOae5d+Y7TulNhTihAeG3cfRVUf8OTGqnwCs2GVL8twylU8QhollofcccSnU=
X-Gm-Gg: Acq92OEKDOPOAXTcYE0LD5e0HWrLMAOUIU+9uRVqsojfUqhsqW1oannIYfcUz1h7Gm3
	Ia9CYDaplEvh6o/Mmv1MJgh7XqyhPvOsC4RpRAJw81oGw35864r1EOc9J91RK6yD9TD7m503grY
	gVtr+KxPYF6sWRU26Cc5XIUmnHqMnme/MEtTv8iPgAgBwrzrvgqPrPrl+OxXAEhZqOvVJ9t1djB
	wSbm7Gqzly2QVeQcZthgaKDG5q0dBdE1egEm+rYUsVvEKzqrNFePujmIdcdkVRI05zdss4A9kkM
	vvhOUHWsfL4Ju1lHqJXU6j8F9stJEBDISw4aSi9numNrbYMa4Hclww8cX6MetyBWeY4+WQ88vK5
	JDczbD/3j+fdMhZ6k7ZVi7DT02ONzo2Pk4R/NJ5o0fzU23lKOlfXd/VmWiOZdohntnuZqNPi0g8
	AXGdGJJJ4piHVPXTPN16Asuljq
X-Received: by 2002:a17:903:2d2:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2baf0cf399emr200710255ad.2.1778588950278;
        Tue, 12 May 2026 05:29:10 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm137845385ad.28.2026.05.12.05.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 05:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 08:29:09 -0400
Message-Id: <DIGP5VDNWMJ9.2HXDCVLOPWAMT@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, "Tejun Heo" <tj@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, "bpf" <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
 <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
 <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>
In-Reply-To: <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>

On Tue May 12, 2026 at 12:24 AM EDT, Alexei Starovoitov wrote:
> On Mon, May 11, 2026 at 8:49=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >
>> > On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
>> > >
>> > > If not, the best course to me seems to be to make the flag behavior
>> > > default, and just rely on ASan (and Rust in the future) to prevent a=
ny
>> > > memory safety issues, and drop the stream based feedback on fault,
>> > > etc.
>> >
>> > Agree that this needs to be new default without new uapi flags.
>> > How about we tweak the idea further.
>> > Let all arena pages be unmapped initially. bpf progs will fault
>> > on them and will be reported via bpf_streams.
>> > But we also prepare one "scratch page". Let's use this name,
>> > since "garbage page" reads too dirty.
>> > When kernel faults we populate pte with that scratch page
>> > and let the kernel code retry.
>> > To implement it the page_fault_oops() can have a callback
>> > into bpf/arena helper similar to kfence_handle_page_fault.
>> > If fault address is in arena, do kfence_unprotect()-like.
>>
>> Interesting idea. So I guess this page remains mapped once kernel
>> faults on it. I guess we can still reset it to NULL if we alloc and
>> free a page at the same address, so it's just a drop-in to prevent
>> further faults inside the kernel, since emulating instructions is ugly
>> and we're not using asm wrappers that have fixup labels etc. If we end
>> up allocating and freeing something at the same address it will likely
>> get reset to NULL (that would be ideal). But even if this happens in
>> parallel we may fault again and then will just fix up the NULL pte
>> with scratch page again. We can likely also preserve fault reporting
>> into streams when such scratch pages are brought in.
>
> Yep. All makes sense.
> The hope is that faults from kfuncs should be rare
> compared to faults from regular arena bugs.
> So the stuck scratch page shouldn't happen often and
> faults on unmapped will still be seen most of the time.

This sounds great, it pretty much retains all arena behavior that we
care about. The most important part is that it reliably reports the
first memory access error, which even now is the only one that is
meaningful. The delta with current behavior is that subsequent accesses
are not caught, but we don't care about those because they are very
likely caused by reading zeros during the initial buggy access.

Would the scratch page be actually mapped into the arena radix tree, or=20
just the pte? Because if it doesn't then I think we don't even need to
worry about resetting it from the arena side. Just allocating it at
a later time will overwrite the scratch page PTE with new valid page,
Until then the page is accessing the scratch page, but again we only
care about the first buggy access.

Small nit: Maybe default page instead of scratch page? Scratch page
sounds a bit like scratch space but we don't actually use the page to
store any data.
