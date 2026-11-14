Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794648574;
	b=CXpZqNR+MeJ145u/NcR7UMDMrlvNdLSy+vwvpQ1/zolkvt+3WxfSGM0WR14ZzHZMEwyf
	 lKpyTCjiopOdEGmXFd1//wS8Sr0o3+aAm57tF+oFwUypZE4j2fSpbLLoMyl4Ud4KDJ+4C
	 BZIgnIxSMKTPi6WGY7LqJp7WJ9qrzfbMOhfE4y3ykWOkp31lgyI7hBkbLCI6eN1BIvci6
	 tMTKj2TYKh8vnQ6kybw2qQLr9AMZ2aDbYDRZv+gnLlvLJt27tF03+KExW5eurwyok93Qm
	 kUDMPrxN+ydWzYechgNo/IRMt2EZtG/SDKolj+0g4VkCWAnRhJmK3CbFu2sRCW6wMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=vz0vstI9OA5h3bsTRS3tRWw1Hwov6sM88rpH9FbtfYM=;
	b=rgI2sRUjGpjRwcVALXKOpHrTV9pYI5raIPXVlOB+izOgfseTyCc5pPTKzYwHF/32K/Wi
	 R7B92MdtLxhIjTfvSw5nvPb+e15I7+lph7lLcd66J8s6v6eRohvm8kfkiYq+DnYn7NuSV
	 2J10ZfLLxxvYijPxqwYU7Z2S9Qm1yOUfNcBLjTDbaItNw3s7RnSoTYomggjuykLQfXKF+
	 kljx1vA9PjcIRIAt8U8Pg9ToC3X17PLQyrtRN7WLLAgUarbLJADVcAV8x4RR9T1YNBwcs
	 L+LqWw7QR6dD95AesLQrRt49ROLXJ91HGuPK5/P2mXMc5zjTxHpwVd53vUHd+kbgemw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBvC6WSB;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C26606A332
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 09:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C26606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBvC6WSB
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so16101525e9.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794648572; x=1795253372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vz0vstI9OA5h3bsTRS3tRWw1Hwov6sM88rpH9FbtfYM=;
        b=ZBvC6WSBenV8D8YKmhIHmzrsfPzp/N6h0hYS/3wHkdiCKdbm4Xtz4No8qQTORs+3po
         OMYGjJKvA/hgscbCUMcKpIsUgA0bXQlRqUThDkXox1dsNIw4CZaPUnywScY/+US/Q1O7
         VtU9CPPpQ0btH6YK0sLKD2WCOxNoPny5NHxP/y1CoNe0j8iPgtRhOkDNwqKDudbaowut
         Hg/7OxMFDrLJzntvbrkEy+Bx7cE0ux9CZkkOs47kPuU8KruPPc+7sDPli2KmBKii60/W
         /IQ8vIXPAruXsqI3GbfdSg3tpLdx6wiYM5cWOd3ZbhU91nDnIeSK4JbT+F1WuLwoT+jZ
         g0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648572; x=1795253372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vz0vstI9OA5h3bsTRS3tRWw1Hwov6sM88rpH9FbtfYM=;
        b=MxT9VFQMJ0hVvzVmrDL79oTLIPeDLX52UbQ8LBotvh6cOSrGaw2qzqxFI14t1qn5v6
         Vk/Cx+WaMkh23mc3tPZ3ZF5VJqeIIMlPu+tT+ItYOf30dLOPnzRcuY4GqbDqDy23Bmb+
         O0qRh1giE8tgYuUJe9KV94w8evC6nmFc/FKcGIoxX7VtGSRnNAmAFGEypCwCfGZ+7rqf
         bh0qCX5QQ3f7vEp6zhuVXxP6O8b5mCyh1NE89Z1qmIkPwal38QVNIQrMLYp9b5S7w6Gt
         2neMC2ZISFPDPeOAz8tNNbl62sPagDmfqyKxKJ7bMpDTZAN2uml1ZwJdQu5mhoc28a9B
         DMJg==
X-Forwarded-Encrypted: i=1; AL+hErFih9aknRc6/W4ASRZz1bmJsfXBagb5OXLHgY7QIi6VzytbuwRx61DupOLQUAnRjnrqMAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xr69+mgJaS+/Z9novudv++o2uoqUzXpI/tK/+DMeHNc0mWgPQ
	Fp8fm9Qw+B8+Z6/nY+MeHbDuJTpAe0Lbxjay1dRfo1A+I+5JKAU6tFdgiY9d+S+S
X-Gm-Gg: AYBFou1L8l31conKjG97EIcY1weYww/qSlXYyqKKy6ZMMNbko799h1pxMTCSqJn3M+L
	5G+/WuA9QJEvt4fJTHdxqfFoO6AtGMUwBiii4u3K/cBirrnbu5qTvLki+mzbsWfI8Au6ufda7it
	S6/Im2ptXj6Z++Fa+5uwQKMQJqE1a678m3pdt1Qyv8z254U0Pf25m01DNRc0pM93cROXb60k9Uf
	1aEB1FFmVhyZycZtn2H6oAJYXBvPMl68wmbJz+U3spYROzxN5mhYQ0tGnaXTm88DVkjxedjqiaN
	hCtS9azfju0PCaiDWw1KJ54UATbCL6o3e1yc91a9PDilgi9Mqycy4pO7i+L5e0n99v/XHGyLojg
	iZRFi1spDjF5dt1Riqb4X81EkONz/ZFKbAaRW1q/Lk7znUBfvc4TV4qwgoXsVZE+w7Ak8hgikW8
	iZ3jEKoyDeEIm1G0rjbmN9CgXNJ8roDdCvbxJpC5qxp7hu037H+ErkrXfCdnWU6igCfweYCP97T
	5AWYxs41tVp7IhVgaEvpSv4lTqcJ0H9Xr6OBkiKsjcFhQvNxkR5ojM0a4X8qxB8DNC25FmLioB2
	zCJ8dG+nSNlELevZyOAQbNvpE+ryOA/C3GJzuelM4bbFsjiHrcmRkhLEZxnq0fMTkt7iVkjo3Gv
	TtDCqcDI2UGg45DP2PHga3nSG3e6sHY7o9wmTLYDCihLTMgIWDXwzEKNF+UNX8O5VWDUwN7CcOn
	MZRpNwRiYTet+AdbuuIWKWCEXo2C/TbOo0iw==
X-Received: by 2002:a05:600c:4504:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb559f044amr99585225e9.2.1794648572072;
        Sat, 14 Nov 2026 01:29:32 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b358-dd01-fd08-0f0c-fef7-8409.310.pool.telefonica.de. [2a02:3100:b358:dd01:fd08:f0c:fef7:8409])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60da0a03sm8078945f8f.53.2026.11.14.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:29:30 -0800 (PST)
Date: Sat, 14 Nov 2026 10:29:29 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: Pre-allocate module page tables for execmem
Message-ID: <avgpqlpWf01mwo9P@gmail.com>
References: <20261016102847.96530-1-kmehltretter@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016102847.96530-1-kmehltretter@gmail.com>

On Fri, Oct 16, 2026 at 12:28:47PM +0100, Karl Mehltretter wrote:
>   Unable to handle kernel paging request ...
>   [ffffffff78000000] pgd=0000000000000000
>   ...
>   bpf_jit_fill_hole_with_zero
>   bpf_prog_pack_alloc
> 
> Use CONFIG_EXECMEM for the module-range pre-allocation, as powerpc does
> for its execmem page-table setup. Both CONFIG_MODULES and CONFIG_BPF_JIT
> select it.
> 
> Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> ---
> Changes in v2:
> - State that the BPF JIT region lies inside the module region (Mike).
> - Add Acked-by tags from Mike Rapoport and Björn Töpel.
> - No code changes from v1.
> 

A friendly ping on v2 of this RV64 execmem page-table fix.

Is anything else needed from my side?

Thanks,
Karl
