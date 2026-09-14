Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB34229D9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425143; cv=none; b=Dqc85BkKucBCtxXbzIoRKbcZgefxkhxemn3cKTLraMlV3nFRSQfZ3Vwg0ryYPmYIxG1F7gD2TPwewrQo1whVrPlI9Vg8OQNjy7xsqGZG/Tvil8ffaNTobApqmfCqu0OrCrYcIp4LZRPnhZdih2h1mymMpvxoOjoN1GyTSr9iTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425143; c=relaxed/simple;
	bh=2K2+Q6owcaRQPAZ3ACLtiWUXPfmyIUG4fBuKDbgQeoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARXIvLSDoTyF4XNHJbyGoXd27J84fugHym03Eeh78TrSUpoLDjAjbfaoK3xjiCUOEBrf0Pr0OMXCgbVKXngT+teNU2j/ckZIjaRh1u8+YqlOXIhUsC6w5DT4fzVQBi3SRyOKMCkEdaMrV2UWtztUbfc6FGI5R5mrLFkHv8y2vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLszFhJv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLszFhJv"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so8745ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789425140; x=1790029940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/mgh4gWTa/ucSTLn+qewaTi2SshWtrqgS51IF0oOeU=;
        b=TLszFhJviWjSCXYIF6cvuK39BqUCITTBgEbYnOPFIGUDLyNj0TAKSy7IWEgKpdvivd
         6Uz/nl/HwCLga47/lnuGHtpoxxEsiQxrKEOA5MlAVMSg+WAyFg/8S1O9zD/j9b1NnDBT
         /Dv+/aW5VUqCY2q7FrL++thDG0KFk00zy0+igEZdKqk/78GX3eMscwc+UVo1j4PuY1Tz
         vo4KE2hhzyLv/OTpmGlJ2aXAzUqSttRuNDbQQU0aRo4FvEDRfPpfj0AeWMhpGYjOMepU
         dMCsDnkXhIXEbOcoqwo/xcZ4D+OT3oTgWoihLhbWu+Akxy8HjeBkHTAVQnoVaIXpYI1c
         84DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425140; x=1790029940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h/mgh4gWTa/ucSTLn+qewaTi2SshWtrqgS51IF0oOeU=;
        b=CY6fc0WtzYyi82P3oc6gdR1KcYwyXLkUSTIxtL/PSWfmSqgroR0O48iWM4JRDgybPZ
         1aZc8KSaD4BbhFMgEMNLiT+Xws5dLFHULmxzopnXhV84ZcEm6LsJfUJz2QrD+86pYGqg
         GLzruO8VvCcladPX6CEpNFwvUSUNkJxSGZnIqApNyJQCTLDF67OEM2NUC1TMDcWS6DxQ
         X4JeSedwNdX3lzTvueYiwuxbWL6IMSlHBdMx1WEZf+aKEyPkgSmYEp82g2FzhFMAqutB
         o13yCXlF/Xi4QW3XQuTUhqIgN3YcqEZJy1B3pEtp1XyiVSVCnAtFq90KiPG6uRXWZwg1
         a1rQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDnntxhnyGolJoeco/t54BzJu4/mAma5uL1iW4xC4jBrfaM9TZWzrzCXEKOEyqEsNy9go=@vger.kernel.org
X-Gm-Message-State: AFuF++nOydVQEkm28HA5W0MErudFuV9RaxJz6fpNc0rAWGZ4gs7EDzxb
	6iBU+FV63wqY+Bs947FuwNgf9+uNEwJ9jUDbLL64qCaqFLPtgaR+wdx6QThRDYUHHA==
X-Gm-Gg: AYBFou3bDYXCb5rNVQyUzAej7tlnVGSafe8ehmibJrIV+3vY74hauVPr6uB64tOamYJ
	Nz2yVVo4hlBtH68E/bjlxsKyiSjuNGYJQXGYbZBBHIGxdzOD5XMHHmjJwz/yGZI5kzTEEzU65HS
	53CZXJiRXQ65AL28wgp3KI9PbzFaNes1KMFpdd8VwT/SWH8lDFdZpP71NLIln12Jw94u5SCtmg5
	M5uQz3m5etEYeHJZmMJ/53t395MSk1YH9T+2gmoR3wdDtEphA25kWBLVy+neKnDsuF4QXJYhj0a
	eVAfiEUTCM83h+q8UwPLEiEQxMBv5Dl3CQ/amDFo10n7N3wiT9CoOHdlhgPCN7EJBv0HGE45EJf
	trb2Xg34g78gtYyoBAGCy83q2huOjDuaO3mjjMKtfE/D77SyJrjTkXeMskW6bxlcErJT6Gk+Ggd
	CDbUJvhWfDpEEo2GXbQwXovGSdYkIW26eZUSbRePQZyO8OL/ZxjiJQ7OSxFbgqvd2w9BQLcjgFx
	PZWW+8VQ1K9nz0o2Zoo2JJD59vg/3KB97o+LHI=
X-Received: by 2002:a17:902:cf0b:b0:2db:2225:d2fd with SMTP id d9443c01a7336-2dd76be2bc3mr3447165ad.16.1789425140030;
        Mon, 14 Sep 2026 15:32:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9e:b709:96a2:f1d6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1438d1381c2sm1704593c88.10.2026.09.14.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:32:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:32:12 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Xiang Gao <gxxa03070307@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?utf-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lorenzo Stoakes (Arm)" <ljs@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [External Mail]Re: [RFC] bpf: account ring buffer backing pages
 separately from Lost RAM
Message-ID: <aqh17GTlWiDVJ-N1@google.com>
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
 <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
 <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
 <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
 <CAEf4BzYQvhSVN=Hggg5FHzFdkRr4UNBD6yXaBsOaAwbsRpXpsw@mail.gmail.com>
 <aqSNkbhIuaB5D0H0@google.com>
 <CAEf4BzbAOgwQqsRQnY4yxvubLtioQNL_BBHer4ExvNF7Rvvu4w@mail.gmail.com>
 <aqhZEuQTu394hYB6@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqhZEuQTu394hYB6@google.com>

On Mon, Sep 14, 2026 at 01:29:06PM -0700, Isaac Manjarres wrote:
> On Fri, Sep 11, 2026 at 05:04:55PM -0700, Andrii Nakryiko wrote:
> > On Fri, Sep 11, 2026 at 4:24 PM Isaac Manjarres
> > <isaacmanjarres@google.com> wrote:
> > >
> > > On Wed, Aug 19, 2026 at 10:24:28AM -0700, Andrii Nakryiko wrote:
> > > > On Tue, Aug 18, 2026 at 6:46 AM 高翔 <gaoxiang17@xiaomi.com> wrote:
> > > > >
> > > > > Thanks for the pointer. Understood — no new NR_* counter or
> > > > > /proc/meminfo entry.
> > > > >
> > > > >
> > > > > The remaining question is on the consumer side: Android's Lost RAM
> > > > > accounting would need to enumerate all live BPF ringbuf maps
> > > > > (BPF_MAP_GET_NEXT_ID) and read each map's fdinfo memlock to sum them.
> > > > >
> > > >
> > > > For BPF ringbufs specifically, you should be fine just iterating all
> > > > map with BPF_MAP_GET_NEXT_ID, getting its FD with
> > > > BPF_BTF_GET_FD_BY_ID, and then passing that fd to
> > > > BPF_OBJ_GET_INFO_BY_FD to get map's size.
> > > >
> > > Hi Andrii,
> > >
> > > Thanks for the suggestion on this! I did want to express a couple of
> > > concerns with this:
> > >
> > > Scalability
> > >
> > > I counted the number of maps on one of our devices, and there are 112
> > > maps, meaning that there will be between 224-336 syscalls with this
> > > approach. eBPF is becoming more popular, so I'm concerned about how well
> > > this will scale, if we have to invoke 2-3 syscalls per map.
> > >
> > > I had a test program that implemented your suggestion, and it took about
> > > 2 ms to identify 39/112 ringbufs. As the number of maps in the system
> > > grows, I'm concerned that the latency associated with computing the
> > > memory usage from ringbufs will become even more expensive. This is
> > > something we had an issue with before on Android, where we had to
> > > iterate through various sysfs files to gather wakeupsource metrics [1].
> > >
> > > To improve on this, I was wondering if we could expose the ringbuf
> > > memory usage and potentially other bpf stats through bpffs
> > > (/sys/fs/bpf/stats)? This counter could be a lightweight counter that is
> > > incremented/decremented on ringbuf allocation/freeing so that when it is
> > > read, there aren't any expensive computations.
> > >
> > > For this specific metric, we could just use a counter to track how much
> > > memory is being used by ringbufs and have userspace read that. That also
> > > brings me to my next point.
> > >
> > 
> > I just don't see a good enough reason to single out ringbuf maps
> > specifically. other map types also use memory, why would they be
> > excluded?
> 
> I was looking at ringbuf maps specifically because they allocate memory
> for the ringbuf via alloc_pages() and aren't attributed to any counter
> that is exposed to userspace. The other maps use either the slab
> allocator or vmalloc() to allocate memory, and those entries are visible
> via /proc/meminfo.
> 
> > If you are worried about too many syscalls, look into map iterator
> > program types (grep for SEC("iter/bpf_map") in selftests). That will
> > be super fast and way more generic than what you propose. You can ping
> > such program in bpffs and that will be you custom /sys/fs/bpf/stats
> > implementation that you have full control and customizability of
> > 
> 
> Thanks for the suggestion; I'll look into this and let you know if I
> have any questions!
> 
I looked into this, and this works in reducing the overhead from number
of syscalls, but the other part about correctness isn't handled by this.

For ringbuf maps we would have access to max_entries, but that just gives
us the amount of memory consumed by the data portion of the ringbuf, but
it doesn't include the 3 metadata (kernel structures, consumer idx page,
and producer idx page). I don't see how to derive this value--rather
than hardcoding it.

I did see that fdinfo for the maps does give the total memory usage
via bpf_map_memory_usage(). However, that value includes structures that
are allocated through the slab allocator and vmalloc, so using that
value would double count the memory usage in the system. Userspace
doesn't have the information required to break that value up to extract
just the part that is allocated through alloc_pages() directly.

I think it's worthwhile accounting this data correctly, as on our setup
there are 39 ringbufs. This can lead to 468 kB -- 1872 kB of unaccounted
memory depending on the page size.

--Isaac
