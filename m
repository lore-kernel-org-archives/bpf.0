Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DF155C87
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106418; cv=none; b=Cd/uRMjEGdXF/9VnyYfkZxWMt8YY/SLkX7j4FZizz62R0yIt1e9Vh8Aog8wQDAJK9/Zq/j//IaKxvOQ8VKnT3LrO+CbHAJQX0ZfczKbua622JjolPf27JuNTv7XOHujPT3HT9tOXamL2GoGgBCzozcIRzhncidCEds7x1iGNOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106418; c=relaxed/simple;
	bh=ZmJSZRA6tHUssHLX9+/wvYBGmZfJROCZJ2RPftP9zBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/h4QNpp6l5ffHnpYomq9uwbORzw6qdXwTMUXUXAdSIM8VjGombs4Q/hxqLMQWYb83N/xduZI84rQkxNZSTWIwSWa5Sj+wfatuu+BggoTC/uGT0UXANTykgwFtIKIubMD9QJhB8OJUoic89o2EBbOQ6IBEH6iRwIvcVwr89kDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HNsgLnwM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HNsgLnwM"
Message-ID: <adaa6a78-6a30-47d0-9aeb-c4a2e844cd8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774106414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AivSz5caou2arTKLbWRs647wMMojmmgQWRTWT1VYFc=;
	b=HNsgLnwMFnchU4dnr0YztLn0LXP8lbHcD1uQZmB+KkO2oNtKG7oUG3jkmHOoUQXbMtqlAL
	eAe/jLF95yf/s7Bk2CM720hSmPCnSkxHOqdmo/k/QPrENxegmZaOd7+Ig7hmI4nRKT3r05
	pH8PpQ7HnQGn4Q6bFBjsL95p6niTRYU=
Date: Sat, 21 Mar 2026 08:20:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: update outdated comment for refactored
 btf_check_kfunc_arg_match()
Content-Language: en-GB
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
 ratnadiraw@smu.edu.sg
References: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260321105658.6006-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/21/26 3:56 AM, Kexin Sun wrote:
> The function btf_check_kfunc_arg_match() was refactored into
> check_kfunc_args() by commit 00b85860feb8 ("bpf: Rewrite kfunc
> argument handling").  Update the comment accordingly.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

