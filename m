Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E852F79
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735411; cv=none; b=ddKBw2eWcXn/f6q5lHe4IkERibdJmnmbaAtht7x7PHJMIp903syBZTlCUyNChWWlA0Xg/8Ws6mPfllKM1dAUYuvq4AFHhpyIiWz2ISohD6zDzgwR31W0h9RJjZXNIFZlpVkU7PQyDUYJFGiBGP+JLHEwObaK86BxHh+4ZMART+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735411; c=relaxed/simple;
	bh=faWTYxB1r1z8LEj2RAEE4Pfe9THEg2xwzyWfz3IND+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=GUE3IQ5szTAiyMyP9mP3eqltGFxnUL9aWOEpqZOIyTc62P1rTiPDwY5FT4plDhIfBagJqmNDtbAWJ5MSel8gAFAw5Nsd29Ro2aWiIaEacBs0xE/qCSOzh8hq5ow+9PlWJE7kxvQGS+CDv7Py2Bc8OtEAfuBoxRJULn+Y7idsDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8a+xQJy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8a+xQJy"
Message-ID: <60264dc3-dea2-48d0-a616-ae14d7c2c14b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711735405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejLXMVX3gjZPYohzkFccFuN4Dj+w6Yn3L9HdWfGuzpQ=;
	b=K8a+xQJyyfQLbT9xqxl/4wD9yMcTrGniICFmVVaYXg0Sjhl68hRGEzeAcAvNcbJymemmcj
	LjOGdS/jTWmRZDD+e1JSnKIBgK6COMviqMtZHURRjlAuTRX4TFZeqk9UTtfpHbtXIk9OBI
	yIJnhgj+HlUW41Ld4sfORFVPoZBlnDo=
Date: Fri, 29 Mar 2024 11:03:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
Content-Language: en-US
To: syzbot <syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <0000000000009925b60614c3d39d@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, samsun1006219@gmail.com,
 sdf@google.com, song@kernel.org, xrivendell7@gmail.com,
 yonghong.song@linux.dev
In-Reply-To: <0000000000009925b60614c3d39d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/28/24 7:59 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f2ffe6180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ac8b7b2292ea867a162
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b3ac29180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160153c9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5ccde1a19e22/disk-8d025e20.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/45420817e7d9/vmlinux-8d025e20.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/354bdafd8c8f/bzImage-8d025e20.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
>   __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
>   __bpf_strtoll kernel/bpf/helpers.c:504 [inline]
>   ____bpf_strtol kernel/bpf/helpers.c:525 [inline]
>   bpf_strtol+0x7c/0x270 kernel/bpf/helpers.c:519
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236

This should be similar to the other KMSAN reports on the interpreter using
the uninit stack in the map_lookup/delete_elem helpers. The bpf prog used
in this C reproducer:

    0: (18) r0 = 0x0
    2: (b7) r8 = 0
    3: (7b) *(u64 *)(r10 -72) = r8
    4: (b7) r8 = 0
    5: (7b) *(u64 *)(r10 -16) = r8
    6: (bf) r1 = r10
    7: (07) r1 += -8
            ^^^^^^^^

    8: (bf) r4 = r10
    9: (07) r4 += -16
   10: (b7) r2 = 8
   11: (18) r3 = map[id:68][0]+0
   13: (b7) r3 = 0
   14: (85) call bpf_strtol#896752
   15: (95) exit

#syz fix: bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode


