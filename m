Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691B40D598
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798466; cv=none; b=pBVh7zb/DTWIQBQu/nqVqE6cFriEftsFbHMbjhaBrBCZD1R4gjRTbnt7vl+YRCBom6z8mEIpRPHrnyfc2efGGPUR+ihxYHznBe5qm8Fq13cJd+yjtKPNyGD5aIyRLNeVk2p2jLndhoNQIv2njmyBL+4P974j79P+OSk9uIwEG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798466; c=relaxed/simple;
	bh=3jrehyctvMEc3MHJHTIPowI90prvv9QUFRWeHO+jwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc35NZ7WZJJ482M3lH2wugD1t8ML1/3NZVzQ/leOkY1cyivYvlwQ3Pf55N2eKRAieD9rbxZqXVh/EPtv8d0s/V9gFlOqnJntnK4hOh8IsL+1KbDyFISobXgJakVLAFEeycAOxd72zelO9KXd9vOd8Q/5wHkN5nqZGb7EBxmMh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxJ9UAEA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxJ9UAEA"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-847a52edeb2so160952b3a.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798464; x=1783403264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlu0CX51xYkZya/YVR32N8ij8qBdC/uMMOc3z2Ovtgg=;
        b=BxJ9UAEAZmUvff0zkVEkd0xO67tHkjgehmNJfCfdYo3CVTyRvR/u1q+3JtFT0Mz5wR
         dSTDYH0NmQE+Dk8m2opMkxvJDJipkcYrwg1biV1GpMpc0mAJwYWd7YAMECniekzDgz4+
         apBXO0JLrGC5yDWKajm4bg/1gPYYgfrgb4e5VTe7AuFOGRONKO4HeQrY44+muECxwUDm
         gQ0ElAW/Szi2OZ+I+6bVSKGoU7VLn/Hs3SSalQMX1NWzhxU/K5FBq7mtTgSDaC4WPEn0
         IGSXbwrIwp+YOIoyTeIwpZDm/3KJc+BXtE7/n2x54k50afErwCqy6Bt6oeNK8BIsZ5Lb
         itjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798464; x=1783403264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlu0CX51xYkZya/YVR32N8ij8qBdC/uMMOc3z2Ovtgg=;
        b=rffxq1PvucjxVz2dPFUM162KyTyP9ip76bx9bO+GmNI/u7eQCDpPxyR8+8MYM2DJ2E
         UNN6ADayohvsN0Su/AcHKlt281qqW3XqdxZFEKjZjD0VPW/0mipi1nJ4FxafZismX3v0
         WysFyFiU347EK5oZMJpOIijG5bwCtpqtgNVi3ekT7rfL6xagPcCzSvdf9zgGVNBalr9H
         QYSoQwQLgS+qrZ2H4RFLxnX9Dp43kYoKZrcQA5/rvtMJBIzGtn0MhzImHQDstRwwoKR9
         UQzyjQt80OJbb4E5aujH+c6Aq9gqkRIGNjXuXs/Ea8oYhicLiPqO+JALb5qfPNy/uiji
         H1wQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqWCoFYTgcCO84L6e8ov65EWf99nPotE/C1N7VLcAtdT74LQjNWwBSxFVRA2ijPJHJpe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZ87ldOA1YqXPHjarMOKJ79mX2YQX3wveVdDkAVysfmIj+KNG
	QNkFKoyfftQZp/JC5SmD3rGWxjj6clFA1KkpC5T3Be5mmLGFq+1SITOFQ+gRxA==
X-Gm-Gg: AfdE7ckgonT2ex4Au0c/Z+RVOVCMOfQF3ydUOO9SnBUp65dMVUK05RVPzDzd79z+Uy+
	FNTDfNDkR7SAn7o2ehEHU5gNsffrxy9qjn5UTILUZXcyqJBCI9cNQLuBf+rWeIK9N3tmsOBS6mw
	u4d1atRVsoI3phIKvXUVFe0qYNs7XbzcfYUautWUu5YlLqeIlpXIM0noSBOQw+yE9mq7szyGAwr
	jcXVBBC+J9KCB13+or3UTXpR359bgs5O02C+1axNRxSmp6qUF9i5RQRgkYCaTkThSwUSgdptu6A
	iTeNhdFW1czAon2nl6iJz4z96328Q3rqpyDGncnnDWrR4jW/ZFaJUjVO42ghl5M49o4tIgejNg0
	WrsCsdifUh6yoxMfnNB+YlVKAPrAUpTGOZHm74AC0hiLiuhmK4aNtEbFHP0rOP9gZMJOkYJFW1U
	+sn3xA+RRMl1M=
X-Received: by 2002:a05:6a00:1ca1:b0:845:d286:1fb4 with SMTP id d2e1a72fcca58-8479f3fe9c1mr1760758b3a.50.1782798464051;
        Mon, 29 Jun 2026 22:47:44 -0700 (PDT)
Received: from john-p8 ([98.97.43.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a037b015sm1064984b3a.50.2026.06.29.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:47:43 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:47:41 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Lorenz Bauer <lmb@isovalent.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete
 from tc, xdp and flow_dissector
Message-ID: <akNXhg5K7aV7Opdr@john-p8>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
 <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>

On Mon, Jun 29, 2026 at 11:24:49AM -0700, Alexei Starovoitov wrote:
>On Mon Jun 29, 2026 at 10:27 AM PDT, Sechang Lim wrote:
>> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
>> write. That gives the order stab->lock -> sk_callback_lock.
>>
>> The reverse order comes from the SK_SKB stream parser.
>> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
>> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
>> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
>> deletes from the sockmap and takes stab->lock:
>>
>>   WARNING: possible circular locking dependency detected
>>   ------------------------------------------------------
>>   syz.9.8824 is trying to acquire lock:
>>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>   but task is already holding lock:
>>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>
>>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>>          _raw_write_lock_bh
>>          sock_map_del_link net/core/sock_map.c:167
>>          sock_map_unref net/core/sock_map.c:184
>>          sock_map_update_common net/core/sock_map.c:509
>>          sock_map_update_elem_sys net/core/sock_map.c:588
>>          map_update_elem kernel/bpf/syscall.c:1805
>>
>>   -> #0 (&stab->lock){+.-.}-{3:3}:
>>          _raw_spin_lock_bh
>>          __sock_map_delete net/core/sock_map.c:421
>>          sock_map_delete_elem net/core/sock_map.c:452
>>          bpf_prog_06044d24140080b6
>>          tcx_run net/core/dev.c:4451
>>          sch_handle_egress net/core/dev.c:4541
>>          __dev_queue_xmit net/core/dev.c:4808
>>          ...
>>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>>          strp_data_ready net/strparser/strparser.c:402
>>          sk_psock_strp_data_ready net/core/skmsg.c:1174
>>          tcp_data_queue net/ipv4/tcp_input.c:5661
>>
>>   Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     rlock(clock-AF_INET);
>>                                  lock(&stab->lock);
>>                                  lock(clock-AF_INET);
>>     lock(&stab->lock);
>>
>>    *** DEADLOCK ***
>>
>> A tc, xdp or flow_dissector program has no reason to update or delete a
>> sockmap, and redirect does not go through here. Drop them from
>> may_update_sockmap() so the verifier rejects it. It also closes the
>> matching sockhash inversion.
>>
>> Suggested-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>
>John,
>
>please ack.

Hi Sechang,

I think we additionally need to also block BPF_PROG_TYPE_SOCKET_FILTER? 
Did you check this case I guess the same case is possible there?

Then another patch needs to restrict BPF_SOCK_OPS users. For that
we need to block BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_*.
Let me know if you want to do those as well. Let me know if you want
to do both patches or just the prog blocking above with the possible
addition of SOCKET_FILTER. I didn't search very hard so probably need
to check all the BPF_SOCK_OPS_* to find the valid cases.

Thanks,
John
