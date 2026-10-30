Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355995;
	b=HXv5x3RX3+8MLsSdzxtc86bnRI32OiNr/kvswCv8YAub9ctqmhvG6MSTZcY/sECXc3Zs
	 8Fs4kMgt1ZIHifxQPV7QX1mfkLmQJ8L/9BzkYCyJ9k2Om3blk4dg/G7MQzp0CByIST9vO
	 BPL36ffhkNsxKCQ3SOKu6cCbJDzKInKM7yqYO4/yNwWJ0b94qvyzBr7tZT7+OmHKUxKTR
	 kgHroBHGlm/8JgFuk8QSSLm878Wjq4xPEZBSJpuWOxqXjvmla/aj1N2O7wW9jT8uGZTyF
	 2Tk0rf2ewM/udvWEAelkbkWTCYDuK6fYWZ2rZxRl4kFF+QoqFLQY2qPEMwk9K8F9S1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355995;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=x1C4pyluX7c2DRs0fRkG1SUAzDzrrUCWfmTDf8LAz2M=;
	b=ENn5+GrCRgEZXOhrTxkKY24bIXOIusIFFQ+KJF1SQHCG9Wrqt53oqwNxu4/FQaQKJAnd
	 Y1DkBubIT2ck2lk2G7LvKBJVw8tXKCwhb29xL2Vgs/W1RFZn7bE3XIVz5nawwlpk8tFl/
	 ZPHF5vmY25szfWODW9EJWG68VQUoUO15fsrKLJC2JxTMZqAMa5doBR4RVAdVMEZZtj4n6
	 a3wF4ahifVXfto43UW+xuxovdZVWYlSpa0w5+EppdMT898Zau7FicF26FGFHz8A5nt/GR
	 tOkDEtyxIZyrUvKN1LEnlvsaYwxm1xYvhf69QzG9YMcHO0PdoiSymurFtSam6Tr3IQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH4abygU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E166606A31F;
	Fri, 30 Oct 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH4abygU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABEF1F00A1B;
	Fri, 30 Oct 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793355995;
	bh=x1C4pyluX7c2DRs0fRkG1SUAzDzrrUCWfmTDf8LAz2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TH4abygUs/Bhz5FGSWuM+/1dmwO8Ylm9Nc6sPLcZsYk/iIC4EXuDBTh2l45MBuvlD
	 kKLRX4d7HgC/UcETBg+C+N7dQ1PhHbj1jUoSZmS9Pyuhp3vTVWyRWIj7dkRA3SOLFF
	 1Ino0uuohfB2nriqZ0M8Q4KaKRmNWDzsfSxJWtbXUNgfghUPhwdt06LP6M2blPDbzn
	 tQmOhQ5PH4tPH3Xf2JsdLNGpu5YqI6XofxsW3oa5RjqA5/6opuOjGdfMT3hhraomxQ
	 pvA0UOvQyryvEqKPBSGPN4nVFKdPC/OFnhsPXF1+zevt971no3WHRZ0GnWGsKfs2hT
	 6AIwN9IeuiupQ==
Message-ID: <5689c92c-318b-46cb-92d8-429fac9040c4@kernel.org>
Date: Fri, 30 Oct 2026 11:26:31 +0100
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
Subject: Re: [RFC PATCH bpf-next] bpftool: avoid sign extension in unsigned
 enum JSON dumps
To: Hungyu Lin <dennylin0707@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org
References: <20261030090913.76944-1-dennylin0707@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261030090913.76944-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-30 09:09 UTC+0000 ~ Hungyu Lin <dennylin0707@gmail.com>
> The BTF enum value is stored in a signed 32-bit field even when the
> enum is unsigned. Passing it directly to jsonw_uint_field(), which
> takes a uint64_t, sign-extends values with bit 31 set. For example,
> 0xffffffffU is printed as 18446744073709551615 instead of 4294967295
> by bpftool -j btf dump.
> 
> Cast the value to __u32 before widening it, matching the conversion
> already used for plain-text output.
> 
> Fixes: c93cc69004df ("bpftool: add ability to dump BTF types")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks correct, thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>
