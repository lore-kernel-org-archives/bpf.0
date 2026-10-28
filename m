Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163094;
	b=Spq99M0IFCmZhUBx6+xjeEL66CNJxrHcvWjSagauQiPWDTIu20RHQkFJfPUyEbjd8SRA
	 EtDrUVnaXsuH+YQPzRLeVloL7MCzkVuSro72VznpBDlBgmxazAWt21bSzkEzMxR2+rZVy
	 +GvlRbZb1oX/EKoMdH733cbFCOILXvU+KZvBtkFcr1fKthAUzSzlnzs7tZQtrdlTX3IH/
	 CGKevY26ChFCQT6aR9qGnIt+pStgbOwrZw7lO1prWly7E9NAUr/PGvDaOmGYm0SJ/YLg/
	 pkahtjjGYsvoq3omWcBFaUyq7nX+5VaD6e3mnTUUUDQCeAmHXB0HSrom11uNlAb5fvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QMlYbcJmMZnMxt8g6WK97bZ+dSGzNGT2+aeJ0Xq07ZQ=;
	b=nQlQ57+6JUsCRjC+qjbuAoWPh3KuMjCK6z+DFBBupQ9IIEyEjyQwQrOuvhYiKSf2X25E
	 69WcPJ3THA7ZzEqO5nyGMVLrJlVli6B9IRyR3VurQkoLTVNcVzpY+NYEEneYJLPsiZJw5
	 CSvNTE9xbvjO5W4xpLXI8Tk4T/P1iKABO9KU84ZmdnwjqXCU0Czl+UhWZuiLLXiVIRqqK
	 uCBCbcCDGFNjVGnZBGkWy+BJz4pF7jr3IyIE/Pg9kYmdNbZ/OG32Kv4fieUmJEW/vl+AA
	 8GhEpAurpUo+kiqWrjkZ5oVBZzz7kMhcWU6L5nOph4VoTb/KBTpTmUQrrV7pg8QAV8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XF8vEO4z;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0036606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0036606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XF8vEO4z
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so341761b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163093; x=1793767893; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMlYbcJmMZnMxt8g6WK97bZ+dSGzNGT2+aeJ0Xq07ZQ=;
        b=XF8vEO4zLzNB8UeuOTR1HtsaK6cm07CnoZ1nCN9CMSaTjGhNqBvz+6uWwHDYRY9qdo
         Y2dRQViVAUkVV5FR15nXl39BW6ogDrVs69KxVZf98nkEOIrmuS/lzUTQSJxGSmkXTLVs
         3TtXVuLQm9BUQNeKMEfg8mmbOkzomv1G1QIO9XM1Mt8rCm6PMhwovXCjjPkXFmSuVo1V
         PS/k9kZ2MM3WwQ8TKvsYIkdJr45mQxjN7wKlgQh0D6EAjVNM26DjZQN9nT0QOJkhKp6H
         bnjTVLEcCb6soySd2mRB1xsD8sWuIBAINCCeFhbLTMbIHi2YjXv1qJHz2ibx7L8/Ug6O
         ZY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163093; x=1793767893;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMlYbcJmMZnMxt8g6WK97bZ+dSGzNGT2+aeJ0Xq07ZQ=;
        b=lJsqvtvWQdyaoB4qBcD8/f5wjOn783kZtdl3xQAPm2LEXhSF8FdonLTVtawbkLUksW
         3a+L+gQ7uqzIY49bh4HwBaggZLDXww5xSKVj8+qDYldMYv/RZnBh34iB91w/RdIJ53Jt
         VNpCw97+n1qBo+Gc8hkJjMnOR1zWxbpO5/HwSYyKysUESwy5SWSjn95jIf+WuAs0KHr7
         3BTHQqXCGi4x13JjA7kMHJGwsa2cHMENgjyz2mjCEe/8Y7CtTDiTHT7TbAKSnSQDM3Ep
         fZjfw76QV2on9KAq5voFBgHApYbMlmdTxBKQFNQzv7dGYDK9LBjWIQSztMn59ZpAxFBS
         pmcw==
X-Gm-Message-State: AFq9FYL5o4oDnr+rSvq3C0bvn76OSfn6BY+e7CvvJJLMoFMGf1hglSJQ
	NyY3ISSop8xr8ZKf3PFqOPvzJbufNYhdYSjesswWPAVEr3rnai9nnihj
X-Gm-Gg: AYBFou205uZ+zer0sXBu+moxEzsijn7U/wYSAsa9v1RTPel3eaiS4gGk2dJF/hP86nM
	Vt6tQVlXjFu16g+lnBAfaoYiWs4q0GnJ6G68TMgB1AyHaaghsSO4/qHQ9o9WM0tVUiQ2kF5AH0T
	kiftzq3imqpx7tjfeAe03ofChpz2Eal/WSt3fMhQtKhSmoFzx/I8S1yybQuwnBBUdxk0OhF3gsn
	kx5CgrpSNkB5QatFYYeVxMa8MpyEOF4wXBcddSS1qVAinxHKVluy8ogR99kkdjNtf/Nob3V3QRv
	SR1a32fLHDsBbhkWv0SjsgT5LnaJqciG4uIxlqiXehMVmYVJcZczqMHVSKyuSmgDhBAw12Wu4mq
	uMNUJN/9q7RqGa+PWrtN11XM9mEfp4t18cY25rXEd7STppEXN3fi62VuEyxQL9ZXXHixIaQBUgl
	uNdtO+X0Qq2PZFGHej5mi61M+m+8LWVEyy1HNtMtUalKkfcnqDS+J8LnCr/aa9uPHvVMc48JvJ9
	296mUfBlWUnNxgf95O/u9xiDVbI0MQBLKO1bbviEMgR8b/JMKpw2UetpvqUeBwUW+IcgcrrKbwn
	06JtzcpWsIhwdWSKhPEbLCQb+O3+PqVmixPeDi8LeO8J0T0DEJ4wVWtzKziaGMeqaMaqz/xh+MW
	XUuQyQ9PNQbG+Uxl5PldIQwYZ+e2phlF9tg==
X-Received: by 2002:a05:6a00:4b4f:b0:886:ac28:3bd0 with SMTP id d2e1a72fcca58-8a6e79d340bmr1004269b3a.40.1793163092984;
        Tue, 27 Oct 2026 21:51:32 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662c913sm630549b3a.31.2026.10.27.21.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 21:51:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 04:51:31 +0000
Message-Id: <DMG79K7GBDII.CT0J80HSK1KX@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 5/7] selftests/bpf: libarena: Refill local
 caches in batches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>
In-Reply-To: <CABFh=a704QpvYLiTq7h7VO0KK6bsFWRamz87mgS9=7=Mt=B_aw@mail.gmail.com>
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-6-emil@etsalapatis.com> <DMFVROPTON36.3LX4QMXFDA91K@gmail.com> <CABFh=a704QpvYLiTq7h7VO0KK6bsFWRamz87mgS9=7=Mt=B_aw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 01:57 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> On Tue, Oct 27, 2026 at 7:51 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
>> > +     if (buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
>> > +                          (void __arena * __arena *)slots->objects))
>> > +             return NULL;
>>
>> This asks for one block of order + 3. When the existing chunks have free
>> objects of this order, but no such block, it goes to buddy_chunk_get().
>> Before this patch the existing chunks served such buddy_alloc().
>>
>> A sleepable prog takes another 1 MiB chunk.
>> A non-sleepable prog loses 1 MiB of buddy->vaddr in every buddy_alloc():
>>
>>   buddy_alloc()                       the cache is empty
>>     buddy_cache_refill()
>>       buddy_alloc_bulk()              no free block of order + 3
>>         buddy_chunk_get()
>>           buddy_alloc_arena_vaddr()   buddy->vaddr += 1 MiB
>>           bpf_arena_free_pages()      deferred to a worker
>>           bpf_arena_alloc_pages()     the range is still reserved: NULL
>>     buddy_alloc_memory()              one object from the existing chunks
>>                                       the cache is still empty
>>
>> After 1024 of them buddy_alloc_arena_vaddr() fails for sleepable progs
>> too.
>>
>> Should the refill look at the existing chunks only,
>> like buddy_alloc_nogrow() in your other series?
>
> I think that'd be a fair policy, the downside would be that
> consecutive allocations
> would fall through the cache, but that's a fair tradeoff. It's easier
> for a user to
> preallocate memory into the allocator from the mapping as opposed to having
> to deal with the fragmentation you're describing.

Thanks. Makes sense to me.
