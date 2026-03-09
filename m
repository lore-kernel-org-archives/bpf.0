Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD32472AA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024043; cv=none; b=ZZubbwuF5XKp8f/vJuGI0bDCRGRmYRSjSMRCOnrgT8W4LBwR687+2oVylC9m7zmHpI9mlHcp9zmXF01s50zb2KeG/F2WepDH8RxBT4LygmDYBAxn1QTPoA06f4GIjjZVwqgjW22D+x6lyn7i9YDuHTfbiSp8F5xu5Rf5+TLmMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024043; c=relaxed/simple;
	bh=kkkeMufj3QU4XLXst8PxSO8iDARzw4Q7vHW+UXl+cew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQ/HV5OhN3pvPOA9Bg4HdJlOLztoxa8UD+G1j20/JuK2T862yuPClbHheRYSWSlX+/qVgKwv57OnCtPFM6fz5oNyMDcTyrvpQno9OQJLO6NrGErMQKhDdxxf11NoYd3cbYIMmYwIwqWF0FYw3jXWLXGzbZiVaZQ/0hSSUjby2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnYjMOfL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnYjMOfL"
Message-ID: <05345a8e-d683-46b7-9d1a-fbc2e7750de7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773024040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz0VYAM/gG6mgKUla95pci0DcVGFliU6jNBuudpItNU=;
	b=SnYjMOfLZ4PaAB8VzghdkoL3U7/JEvbrsYI4CFsU33HIF2/rneUBtbRTZ7v2MiM+Oa2qRF
	6blt/bu37DFAMVlTM+O6oSzA1bGpoBvhUy5N7pgdQo0VwAITVLHubEdeaLS62bCRCubosW
	ljvzN3cILjVUHxuIrr861vwmKHEms4I=
Date: Mon, 9 Mar 2026 10:40:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Always allow fmod_ret programs on
 syscalls
Content-Language: en-US
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1772804199.git.vmalik@redhat.com>
 <710368d4559b13d2d82a47ef1fa7d70a9a038add.1772804200.git.vmalik@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <710368d4559b13d2d82a47ef1fa7d70a9a038add.1772804200.git.vmalik@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 21:40, Viktor Malik wrote:
> fmod_ret BPF programs can only be attached to selected functions. For
> convenience, the error injection list was originally used (along with
> functions prefixed with "security_"), which contains syscalls and
> several other functions.
> 
> When error injection is disabled (CONFIG_FUNCTION_ERROR_INJECTION=n),
> that list is empty and fmod_ret programs are effectively unavailable for
> most of the functions. In such a case, at least enable fmod_ret programs
> on syscalls.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---

LGTM

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

