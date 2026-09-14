Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4747CC99
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417756; cv=none; b=l+x/KtyZfrBWdJpwKLnksbZYavwJVq/jKq6UMPbUtujtqeRLuMBZsD1s/ArSnrnYjEoYH8mmKDWjexnkhhlpcVJFdm1KZHcvkrwsLk5Y+0pGCbJn+jHDy9rq08s3dQ1pK4Eav7E3aoWbVsIUdoNMtegHi+vdIakPuWvH+L6nxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417756; c=relaxed/simple;
	bh=V8mhYwrBMYJn0Atprf4OLURmdEZN1k4wCeZYck4YItU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbGoSUoXI4d3s8GeSNxK37TfiQjG/2TugC5GLMygD7GCPU8ZZGpM/FuHTYH3dUhPfJE5kq8CYUaOhjaK0EoBxouqLjthkWWNePoO8DXDqOUelDt59SS9dno+2UNd3971ZrIEo+Iyg+959oYukv+bvTJnNX3M1yZ2TOINN5xPat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFH2LnWU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFH2LnWU"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so195835ad.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789417754; x=1790022554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1RB04FVKilnMj3CUMQjbhrQYe/qiVYK3aULFxVnZe0=;
        b=eFH2LnWUDN17cBc6Jt9SLxjlisyLFXIqXmP5FlhdsYeIo4k3/6NF5CewZL3/3X6vTu
         gkm0wZHS2ZAci77GTi2NjriSQczz2tqrPQ5DWYyjBoFVb2oLLx6SIXoJ9gCE7XKVfNPv
         KmBMtr06zkjjrW+7YdjOoJNAnFwXCCzCvIdiiaR0QWmerOlfc4IJyObNJVaN2Did40Z0
         YjliKDeEsRbEFz9I0Mablv3T9jxC/vu1h4dF8aMxRP8E4ZzWCLYWr+qimbaABuAlCvb0
         O+yhD45MlChNrqH+bXY0L1YaJeJiksL2nTfv0WjffMASuTkNmmN4wk8SuOvfq9pzaokx
         ySmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417754; x=1790022554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M1RB04FVKilnMj3CUMQjbhrQYe/qiVYK3aULFxVnZe0=;
        b=zZCbebm8qMO8yv59lLnhoc6Dsqg/AiFvmAmtWaghjEbd6C/NbNFSrLK3xnWI5QnD0n
         gB3XVjwJ4A+LRf/F4fDtcSMrue+bwuq5n8L2ckJNMz4I1A6aGemkc/OQcWPbGKH7mhXR
         pxmgHhG0HRhWZFx0SFM+i2QIW495wrSksoDAND+APkSmwniZVDel4XOf60fl2bkmihHY
         fT2Tb/ErQgGlP1cUUTZHJBmfScT5/FPlFXo+hOr1ODtyMWtn9Ej1FxiphzuL046PFplB
         xXzNQE93+AmpDvTmSP7rnpV3zz7nuJNcUrKjcT0juziqucbujpbS/xnY1jJVHFMlVdon
         boUw==
X-Forwarded-Encrypted: i=1; AKwUvBy6FM0hJ4J9xO1IZ49ncECDY7mtEDAq2kV648WGYnqnBQBh3SCpeIJ64bYSfv143XhqrpE=@vger.kernel.org
X-Gm-Message-State: AFuF++lGToQByVcSwUoRBLia4GPoS+HUZGbJf/hpa1yGckeNIyYXBsJU
	mztCKtfhxZELwooiiEISAJcqeZGEXYJX4JBKEDlVSKe8015e79oVn5jK9ZCFT8vMfw==
X-Gm-Gg: AYBFou2m1MhyTmX0KslTdYHsDaWK3A2WANz3oczjgaG7BmdBQ4pW/PXeueoJrVnT4rO
	SdNmL+ygLX/J9L24JMRfTirdSvEIMazFuu6myZE8BC4bfdQrSmvKQghrIUkJTTkg0zSwqPT/2RT
	4vCOqlixdMqY++NmuFAISCanG/Zvj9ugplVLQ3nQ+VNrubkWbaZQXfElbNl1qgfNXih2KQkQIMG
	jd3QZ/fyuUpo7tanGXsKtyYlJF94ZIXMUxwk6RAXOF9Cd3vQWKwU5pRNSQ7ccnJrJeGpxgNGL6B
	7ika5tiSe8OTiLRf0a0PPPUC1ZYc/aYvhmVRjvPxfSFI9iusPQCQ9Rs0Z1dQ+kf9vl+DSh2Zo7W
	VOVkyCQ4KWcbC2NKkhr+ynIfttPvPd5t1HrrpfNzAZhRnXnkC9O0asVzc+H/MLfZG+HlYbQrM05
	XUKguuDU2BmD0quFAgZjEHF9Vf74ZlAtKA4ibWvx+xxmG9jd614w5KhZI5qTDJ8Y7PyaiVx5edL
	m1nQET9KqHK8c/4GVD3+Jy4CJ0u6Btwc+0NqA==
X-Received: by 2002:a17:903:1b63:b0:2d5:cad1:a2e8 with SMTP id d9443c01a7336-2dd76b014dcmr2269015ad.6.1789417754079;
        Mon, 14 Sep 2026 13:29:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9e:b709:96a2:f1d6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm27582654c88.3.2026.09.14.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:29:12 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:29:06 -0700
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
Message-ID: <aqhZEuQTu394hYB6@google.com>
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
 <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
 <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
 <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
 <CAEf4BzYQvhSVN=Hggg5FHzFdkRr4UNBD6yXaBsOaAwbsRpXpsw@mail.gmail.com>
 <aqSNkbhIuaB5D0H0@google.com>
 <CAEf4BzbAOgwQqsRQnY4yxvubLtioQNL_BBHer4ExvNF7Rvvu4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbAOgwQqsRQnY4yxvubLtioQNL_BBHer4ExvNF7Rvvu4w@mail.gmail.com>

On Fri, Sep 11, 2026 at 05:04:55PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 11, 2026 at 4:24 PM Isaac Manjarres
> <isaacmanjarres@google.com> wrote:
> >
> > On Wed, Aug 19, 2026 at 10:24:28AM -0700, Andrii Nakryiko wrote:
> > > On Tue, Aug 18, 2026 at 6:46 AM 高翔 <gaoxiang17@xiaomi.com> wrote:
> > > >
> > > > Thanks for the pointer. Understood — no new NR_* counter or
> > > > /proc/meminfo entry.
> > > >
> > > >
> > > > The remaining question is on the consumer side: Android's Lost RAM
> > > > accounting would need to enumerate all live BPF ringbuf maps
> > > > (BPF_MAP_GET_NEXT_ID) and read each map's fdinfo memlock to sum them.
> > > >
> > >
> > > For BPF ringbufs specifically, you should be fine just iterating all
> > > map with BPF_MAP_GET_NEXT_ID, getting its FD with
> > > BPF_BTF_GET_FD_BY_ID, and then passing that fd to
> > > BPF_OBJ_GET_INFO_BY_FD to get map's size.
> > >
> > Hi Andrii,
> >
> > Thanks for the suggestion on this! I did want to express a couple of
> > concerns with this:
> >
> > Scalability
> >
> > I counted the number of maps on one of our devices, and there are 112
> > maps, meaning that there will be between 224-336 syscalls with this
> > approach. eBPF is becoming more popular, so I'm concerned about how well
> > this will scale, if we have to invoke 2-3 syscalls per map.
> >
> > I had a test program that implemented your suggestion, and it took about
> > 2 ms to identify 39/112 ringbufs. As the number of maps in the system
> > grows, I'm concerned that the latency associated with computing the
> > memory usage from ringbufs will become even more expensive. This is
> > something we had an issue with before on Android, where we had to
> > iterate through various sysfs files to gather wakeupsource metrics [1].
> >
> > To improve on this, I was wondering if we could expose the ringbuf
> > memory usage and potentially other bpf stats through bpffs
> > (/sys/fs/bpf/stats)? This counter could be a lightweight counter that is
> > incremented/decremented on ringbuf allocation/freeing so that when it is
> > read, there aren't any expensive computations.
> >
> > For this specific metric, we could just use a counter to track how much
> > memory is being used by ringbufs and have userspace read that. That also
> > brings me to my next point.
> >
> 
> I just don't see a good enough reason to single out ringbuf maps
> specifically. other map types also use memory, why would they be
> excluded?

I was looking at ringbuf maps specifically because they allocate memory
for the ringbuf via alloc_pages() and aren't attributed to any counter
that is exposed to userspace. The other maps use either the slab
allocator or vmalloc() to allocate memory, and those entries are visible
via /proc/meminfo.

> If you are worried about too many syscalls, look into map iterator
> program types (grep for SEC("iter/bpf_map") in selftests). That will
> be super fast and way more generic than what you propose. You can ping
> such program in bpffs and that will be you custom /sys/fs/bpf/stats
> implementation that you have full control and customizability of
> 

Thanks for the suggestion; I'll look into this and let you know if I
have any questions!

--Isaac
