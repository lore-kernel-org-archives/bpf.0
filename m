Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307126;
	b=w1Ash81wgf20z3EaMw0Z9sdycH6WVSmQcHaeikI7WWkad7fpl6WU0cRL3r/SpnUV9ssO
	 /9wEWtHz3rgCsVYBKhRr9TmcZNT7uioD/Z8cwxmybahmwqT3mHFqhcz0rRFRB6RhY3rng
	 vtD+VzeFWowwMUW/SWavl1z8uzJamq1eXlF/z+fTyAZ6+WHTRyCUlmTVzxE44rdL63WNh
	 kXqcQIG1HAJjVfocD6oXor1ZhDN6hwegJufXksXzi2RcJo7ruVY430BxKd7t51Ec+2zX8
	 N1I1aSWl8nXONh6kkhbz7263X38SxadvTZDiRsFwrr2QvIFOKHuwW5YY9JS7SkuyPrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307126;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b7RsvI0hOcJh521Z4xHa3Ewqq2iR4xhkA+9avBbw1hw=;
	b=Zk9R8nq6uLo6wpBBgApgdfxQ4IPKHbgJv2n4/gC8svlkj9N9Ike5hbe6w3SRy0ca7dHb
	 i98s9tHsCJ5flgg7TLPlNU+nY3KZw+Ca+BVR0EXwqAGnCAaL7Ww3Ly+Ue4xcx314CQxwy
	 itzrIeoPBLkFDo53DrDhzT+X41U6C7kKXwgmhqDuJDx9MIErJ32DqMMPtrigCWT/mAxtH
	 aRHAPmM0x+WyllNwGjjZTIlii2nYjnUocoOr8Zx57/5y094fT1JJQJ+2hYZ2BJLFJEoMg
	 IJ0h1gisYhWSQiUkOxlaWQ63cYaMWO5/kDTgjO/yAihJ5aVlQrWJoCixuah5VXA4owg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.171
Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496060A2617
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 20:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1496060A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qSCjsS16AB3q8ughFksRp3XE14xTUtnLCcAS81y8Ffw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793307112; v=1; x=1793911912;
 b=nOyVJ96AibP/oZ0914t1AeW9/9WIBU43tj8nVoLiojmP1aiFmwM/lLwk9HCxYWxTFjs7skph
 qbm1WJ8FCULhoMGX1vUJ0mWbVgsz5YNVXW5ynXMRV1KVxzTUlOt5h2omGiS/vd7ojZYcOufzl5C
 rIbUqmDdGaW0XkyHbnalHDdw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 12e923243a9eb27a;
	Thu, 29 Oct 2026 20:51:51 +0000
X-Mizu-Trace-ID: 12e923243a9eb27a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3c020a05-5023-4aa9-98a9-b9cd1de3b2ae@linux.dev>
Date: Thu, 29 Oct 2026 13:51:45 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs v3] bpf: Allow bpf_d_path() from filp_close_sync()
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Jiri Olsa <jolsa@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261021201400.5409-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-21 1:13 p.m., Ihor Solodrai wrote:
> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs.
> 
> Commit 056069eb2b66 ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
> 
>    test_d_path_basic:FAIL:close trampoline for filp_close was not called
> 
> With that series, close(), close_range() and the closes on exec and
> exit all go through filp_close_sync(). Few paths still reach
> filp_close(), dup2() being one of them, so a program on filp_close()
> no longer sees most file closes.
> 
> Allow bpf_d_path() from filp_close_sync(), but only from fentry.
> filp_close_sync() drops the last file reference inline, so by the time
> an fexit program runs, file->f_path may already be freed, with no RCU
> delay for NORCU dentries such as pipes and sockets.
> 
> Attach the selftest program to filp_close_sync() and keep triggering
> it with close_range().
> 
> Add a test rejecting bpf_d_path() from fexit/filp_close_sync.
> 
> Assisted-by: LLM
> Fixes: 056069eb2b66 ("fs: make close_range() synchronous")
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Bumping this, in case it fall off the radar.

bpf-next has the failure right now, we apply the fix on CI.

