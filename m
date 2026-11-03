Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793741313;
	b=IiVqMEvxJQEohjAu467o8OBEvyjGG8S/UtlYWhPFANysjOKDj9ZPaph6JeOl7ay0KhkT
	 EvrC/for+OXMxhPKnxxYH4lw+4hG2sotXwKIKeFwMg0vDOzBhhuEMK76M5uVwy/PY5Jyr
	 iNqQKYhx+1ZxfcbX0mfnYuiDPZOvn9VarfRJYBJKUJUKMCSHyWbi6OId38/mDelbkvKhx
	 NJpFCrYICjIsynfcP+4OoprH01tRAYtOltsZi1Qjk1nQBmwLlaWVEMmni1gvbcPGj9SQa
	 c46ftlYowHxIJkK8f6R/zOAMvkuZD6GZVnQvvXc2ppfvmqwbf+GTSpjRK73wO7HnmHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Zmm8poGbAfilcXs4zw9T7e9Y7uCQf8mtPuDLoGEvUrM=;
	b=1gw5+S4NpZ40to1Rw+UuJ1C9jFBAgti5U3ubQSGiPXN3K6NS1mr+0kDvak7FWVUMIh5b
	 MUJJewXyU9pj5zGoT4WOH8/sHl2YZJY1VXw/CVfRFHLDdAbNxwM4HUIGlRS6AgE/E7xCg
	 Bi4T30699JawyYaRF9T9X+ZcrEfTaDE/iNTCcWXbVYdhvgtod2XvrrTFkbVe+FzRUGbDA
	 iYNrQyj9GJCtPbMsLRcrk3vPF4YXSoG3JEkHrXutnBBSpgvUSvk/dLaE/MXFjWX+ebVVE
	 0XMlqGYDzqyY/B9sRHOA23eac0sPC98xfuif5Z5ciNLh8xfAkjQS/kRPPCruH9MWZ4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=RDzHdzJM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DA606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=RDzHdzJM
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd8b2b817fdso939a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793741312; cv=none;
        d=google.com; s=arc-20260327;
        b=rk4LVQO1BI1JNVWIY6Ateibf6RVfF3Ll+Urq17PlD/bhZbQ1q+2wtuSeNWnSbqmWbP
         ylxU50ncUIrCBA2DT7K+3PZiMI1C41sLD59GzBO6vE9JK3UdqItLSpUTu5VAsQ1OE7+q
         /WfPAXgNPMmz36m1P5m0UGp111J2yR8qhnY01uh1+3WXES36Q+nw2dil0NrO6PhhAv63
         XuQYksmC+kXuZDFNjc3p3JW4gN0g49jggi1ZrWTFOJIJQzB7yt+N2p07+8V36XOYH6WV
         nq6qIu8e0fOdLX8N6FAvZYmM29EJ/6h8UyIKx81e8sTxQBSYNNewfkIU8jMRBzO7AXMe
         MMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zmm8poGbAfilcXs4zw9T7e9Y7uCQf8mtPuDLoGEvUrM=;
        fh=+yD1pp0VQSJcIOeyr7aGl9MaNldfEqwK++g2J+jhu/w=;
        b=izUIdWHqN8o353AYWLMExa4pKeYYjRgq4dJletmviCuXcWc67n9yyX567KANdlzBSS
         zhZdl6WB3T1RQmY33xdKiALgwakfl977qwO12JYAgKeyzuCLJj9jI/IzOLpfVMnBF8PK
         0kdm6tYuW5hsG1YPPHdLcjgIXSr73yVCYb2E5IQj9AriR03LwQPMOSd5v6bI4msrpZjY
         S+Kc6zCkPUiFOn+fuovI6xQUPVd1YPHDFvnHwsTp9LeOP+enWNd0xj+YqNcuxDZs7TEn
         WJdCBoqVRzf5JbUCDlZFkwMKob6BmueoVhgX5qHXm7H9ti4XXMV5ktUhDek69zg82ARi
         DoRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1793741312; x=1794346112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zmm8poGbAfilcXs4zw9T7e9Y7uCQf8mtPuDLoGEvUrM=;
        b=RDzHdzJMeUfiUq9G/7lFmj/hNY8UMX6ikh9NfglyTlaT4ewEuBKX4XrY3AvxwgX9zO
         iUmqR+LBXrg8omLshdjCH+2hnkExL+Dl7U5QlSCKcN+DJOyfyKHkMGLOIS9AEWM/DNfn
         jck57X8KgP61dTHGpxXglashRzCrboGRhKywwO1xQn3xbVDLf3cqF1JCAL4VFjOkr6hJ
         STlWyl3PH6WF9liLzVJVT0VpCF1Q0FjzLZ64fBNcUV9Le2G94K7Dz1F/mpeQWcC2ZQL9
         Y4WEN4MfiIOvX89YDWCDxeOiRPuaUnD1TUTRspdmv8tJ0gX+CxJv8P7OUr+URmWZ8z47
         kbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741312; x=1794346112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zmm8poGbAfilcXs4zw9T7e9Y7uCQf8mtPuDLoGEvUrM=;
        b=Uag3vvntZvqwqbwBZxFbJll9JS9cs1V7VVJaxl5q1sPZmotDv+oUF49HC0Nkl72lNp
         Df+SvZ/NzGx0QJDmKbzoJf3vGGyaDa5MIq5juTjSmQl+0stQqG0Ftk5Y5X7nkexdaxL5
         9d5Z+U72hXwxMcbzSc/3XwL+3cH14MuntV6+u9EJcqOlXd6yPWkKdXdlgqEhw4eV5Aq0
         K4wHu67zLOT9JW/NLnrQg28pPym0zO5QOnNMPX5ZSidTpqfojW4Ho6sOLDTqpOzR6z76
         VOQ5zk269srEK9Wzbufr8oMXkNGDcUZ12bQCNyEMDyMl+RSaPq9sFmpOOpXIvA8JAFZG
         caHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWWsJKBRvz7qCkUu8hxDSE2TGDB6Y8tkoOGlVVmRvUYMXRDqUKdLuohX9dXfraDMxaNYA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gUmQ75pnYYxInS5bvLNf2VfOatLYZ0FwR2s5+L9IsIsfdR+BF
	tXm2xVesA7O+sN1Zdhgl1qnTK7+MV/mNMHiCIF1ohQ+5WCuCtAtBWXbtMyP6d2ow+IbNJenzR3u
	VwI7lObeYyZ7W+2D48WieWAhvFhIul4Wztgd01YCxNA==
X-Gm-Gg: AYBFou26skCgL0db1OqgfWNb1Hg0zLPd29xM+xNOLTCZZ8r9UPNIj2WLqn0L7nQJfWK
	gHC2whiyKchw+XyYflCcAWlNt8pPMQFZcOHI4xaeJzCbS5m+JTxe7MH9/7HufeCvq0zZ7DQXEKZ
	aYz+gW3B46SuQYuhkatwHT0Vhkkc2D+ruknh8wvlWjXLF3tPdrQ34JsdakzpStbaxM+qdXMlQ2A
	P+ln1GvAIugxmd/t8BmXRu7LLvGVD3rIsAHe6nShIdPZltEnIleR/nrhLnGGhaa2cXbs8plCy+/
	wjx5GROgNqrfO70CXFk0o1Beo8fKRm/d22hCSLzieTJexJWCbXr0PNl2M1ki0NOfv6NJWkMONr2
	mjtnTOZBw9Y455hD3gZfOdpYzq2xtTwIAvA==
X-Received: by 2002:a05:6a00:6403:b0:8b0:4ee8:10b7 with SMTP id
 d2e1a72fcca58-8b04ee82e42mr1269223b3a.1.1793741311690; Tue, 03 Nov 2026
 13:28:31 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
 <DML75890DWIX.EYB690LPBM1O@gmail.com>
In-Reply-To: <DML75890DWIX.EYB690LPBM1O@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Tue, 3 Nov 2026 23:28:35 +0200
X-Gm-Features: AclHuK-9dIJ91oRBVvYH-QEQPVhpa7EQfrKjcAYWov7WHRhtMGb06DwMyyDhFHk
Message-ID: <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 03, 2026 at 01:49 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> No. I don't think we can switch to per-task that easily.
> For your use case try fsession. It was added specifically to match entry/exit.

Thanks! fsession does keep entry and exit consistent. It doesn't recover
the skipped runs though. I ran the selftest scenario with an fsession
prog on __set_task_comm (7.0 kernel, lazy preemption, 20 rounds): Task
B's entry and exit runs were both skipped in every round (entry_b=0,
exit_b=0, recursion_misses=40), since each run still goes through
prog->active while Task A is preempted mid-program.

What is the main obstacle to per-task tracking?
And if per-task is not an option, do you have another approach
in mind so that runs of unrelated tasks are not skipped?
