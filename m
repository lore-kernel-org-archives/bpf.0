Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895841;
	b=4/0a9peSiUWJCCvrwAAMR9ltW/6fezX9hBbrubw2CkXXA+is1bhpimAV93fTlRSIZ0Bx
	 EJGD6cjJbd/t5BL9VUvlqwlEdMDb7SpaRbfscXFnG6E/Cg6qP3yqKNftgQx3IOLG8Pv99
	 xjrmZeow0fb7eqLXNbROMJWo+vOlTmvTbmpwuvzeg2C5QOragmpjfoojTw5Jf/TFIGuRK
	 jyt+6PNU2w6UeQrZ7+wLh/hCfJiLfrcV9I5+kzmWpLluBNLvPX8FZiIrXEm/CX9vmphpH
	 /V164rzj5LX8/P/Oo4sZLvePWP0DUjh4JstHBYG4m66gTBVxtaGiVk6RkieWm18UG7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=vEatsYln1JH/NSaGPfeQTStpuozS299aWgZQYhTiFGE=;
	b=MAKu23U4jftnvDLpruMyI+ll3ifiCk21S7hWKUhnpytip0ZIkWPAMcnLOXJejusrfG06
	 JnBnAb9a0n45wDAoqAnOU8K2b+os+Oy6wIU74xVs5v4UBjzYiPXXWitVN6LcLtdPhvONw
	 ZPgpTpL8CnjulNyqj6e2fRB/MClDHsAKnnO4TldZn5WcrC+4xPi6KwqxmAyUP7JVGAdpE
	 xNyNBsL81lqzuS8Xiuym1StyB6ineZXKoDA5ZZYMHKHmFJrCH/F+DXKDXC0I6+GEzX6th
	 tv/mXJBRKO4mOGNDIJSZT9e85e9Xgj76obaPGDc3GT7xHsoJkTvVeIpdcOA100PJ0OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyvtEmvN;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F50606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F50606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyvtEmvN
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so335709b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793895840; x=1794500640; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEatsYln1JH/NSaGPfeQTStpuozS299aWgZQYhTiFGE=;
        b=PyvtEmvNdSkVSX4+M670yPyZ0FpkwbJzhNSx86sdw0LY9UKFfNGKwR16qRtIVxG7KU
         +K7ZAFPFHZMb6Ug4SzX6sLU14GHBrHiokhbIGwYxyv+pRVS9uWq8gryicZf3Ghb0B/Fu
         uZ1zSk4KPQF+EqnGb03/gq+m1jVZmXKyrHZ9MBZ9cZN7Nj4opqc0fbn674Iw6vHAYLen
         FsmqRJb0zQtj3x3Swgqqv6kuArjPswccWiwQ2FDdzj6LFMwF/LALamGNGiDis4Wm3u+A
         q+FnPotYcyzFg52pDqAektvxWWJQy49sPEgvJ40aiZE/D8nHGeZKVrmHVRvDeseCPfUc
         /EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895840; x=1794500640;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEatsYln1JH/NSaGPfeQTStpuozS299aWgZQYhTiFGE=;
        b=HK1fkpre2hzYTvg2y0+6TP3D9TmkuoaKoX8Uk99+2EPw1dTv0mHZNZLuOb2ZUW/ZIu
         WGv1RDXnXW6araR6gUD3v2NAdm2OuL6/lu4al8SWEazsfpsp5a9GOOeXoBPwsT6C66G2
         PEnWgrudY78k/aZGMJkUFPeH+IOlLsGP3dvmixdNXpaSPT+swW5Qh5vNgxxYLNRmiuTz
         s6oIyRTTMZuK8vOE/Ep98O+mmFccrXVJyiv4W3sswCTYsinnkQ4HAtnPBU1rtxMzGnOx
         lvKD2KV53ywWIQIPxhTFqr33/ScCAmNjB610Hdoe/AQKNvR1rvtE+mqDQAp0X4n/aQUI
         nGNw==
X-Forwarded-Encrypted: i=1; AKwUvBypcnigDhx42oNAEplsn8KYC28KFhmisMFcdczhUUXzJsDrXoi8r5z1aa8G+NoxZTViqdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gKXOHWP7Krv4sbj2kd+M3cuVXhWY8Ms36TzS4GyfVM6ikgCbL
	0I3U4dWuQw/ehBezq6DQvm39QVGF/WG5+AX+D/Dch9u/6YrdwDPaO0ZK
X-Gm-Gg: AYBFou2tukLNj5xErTyIpL3huHAJXI9r3Z5gl+nWCtAfrE6TsCs3/hR4VeRREWZ9fhg
	2utRjUCI1Eg+X//4eZPlBXeNvg0neibMTFDIsCbj7vqJBpaf/C+4T5P/wKaWbhte9Df3+JYPFR4
	xiimswDKOrJ5P1YLTbHOHZb7pWu3QTGK1y93zgHzLA0Fx6uFCpgh56E325/dQVahjl0hA2w7xrc
	CGnbIGs+yte8h9ICj/ayVW2f4zQbkT3rw7o5rgiG7mmDZqO0He7fDgUmbo4zTmhIdE2ePiq71+n
	LqV5hMaF6sGTf0aDqZcXrXwtG7ANXuWLT+dTvTTwUZ/FG5qYz5ffBEYwl19hutw+VM4TjNbCrP/
	nleKCnnmQPq0xJkdPjXbuQ7Xpd7lPi9uUbNUm40fHbvufp28ALnlI5JmTjVe/Ya4uW3eOLGnTQ9
	CzOazzn6flpiq1w9SDZ8zTT4q92++wrRZpNQGOCrh+Ferf/StuMz65wrMQ5Jv6F9dIDOE9kYWIo
	wO6RFAxpxSeQeJQC0pR6TKSIKj3qFDV8rUrdW7wcFh8fOq1Sb2Ful3TGjKacQrEOwnCAKY1S7Dk
	1X4A1Txd7dJgal0loFvW2EH5U2oOllrekYHzHDaEG4dmEzVgQdrcI2d+Vv20co9efEeMeEjxLYL
	7p+JtY+WPGbQxiodJYKQYRQTBmtOlq9UKOv5ddtHKRADgaX37E0WQAG4LHg==
X-Received: by 2002:a05:6a00:1911:b0:874:705d:f649 with SMTP id d2e1a72fcca58-8a9bf90a9a8mr16161273b3a.43.1793895839850;
        Thu, 05 Nov 2026 08:23:59 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fe12f6sm2215796b3a.4.2026.11.05.08.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:23:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 16:23:58 +0000
Message-Id: <DMNF03AQLNXY.27PRD8XBEYX77@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>, "Zi Yan" <ziy@nvidia.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman
 Long" <longman@redhat.com>, "Suren Baghdasaryan" <surenb@google.com>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: add and use mmap_read_lock[_killable]_nosteal()
 on contention
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <3a77219e-39e5-4e98-8f88-6f90bccf69f0@kernel.org>
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org> <20261103-khugepaged-latency-fix-v1-4-a07ab16ac860@kernel.org> <3a77219e-39e5-4e98-8f88-6f90bccf69f0@kernel.org>
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

On Thu, Nov 05, 2026 at 02:16 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> On 11/3/26 09:27, Lorenzo Stoakes (ARM) wrote:
>> With down_read[_killable]_nosteal() available, it becomes possible to
>> release the mmap read lock in such a way that a queued write lock always
>> takes precedence.
>>
>> Expose this to mm through two new wrappers - mmap_read_lock_nosteal() and
>> mmap_read_lock_killable_nosteal().
>>
>> Make use of this in scenarios where the mmap read lock is dropped
>> explicitly for the purposes of relieving mmap_lock contention - the BPF
>> task VMA iterator, and lock_next_vma_under_mmap_lock(), which is where
>> /proc/$pid/smaps_rollup re-acquires the mmap lock after dropping it on
>> contention and falling back from per-VMA locking.
>>
>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> ---
>>  include/linux/mmap_lock.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/bpf/task_iter.c    |  2 +-
>
>
> I'd appreciate an ack from BPF folks and a confirmation that I could take this
> through my tree :)

Sure. Pls take it through your tree.
No conflicts with bpf and bpf-next.

Acked-by: Alexei Starovoitov <ast@kernel.org>
