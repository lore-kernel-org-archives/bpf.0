Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177C3AD50F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781211; cv=none; b=fJp0mh6pKWteiYyCj3JvuHXzXuszdTQO0oo6ZAuX9psy06aYbIGuMK2x4GBtbQJeKUpNrXcEWqOv+fqIuhliVG3hySXoY+TwwXaclcZyT1Xl75DWglYjB2LCzZIMYPj7syWKIinIphCLPIhX1c7sOQsxe11Um0HKj4KKO5N5C70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781211; c=relaxed/simple;
	bh=uA6h7deZ5T2nPPUM53EJqA3rIZv32XXAgEtZLgQMBOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpDkaQK8/Lzv+LMg9SvSGsm/t8F7YqSdnDLI+1RDxwQH+sc4rp49KbGpXB+ma5P+xQigk8M+EjUALec6+AahjO3uUWLmmmlwzdzxZAogcCdtLI7lIZUU59egE8tvLGZC+6bhwvGLUIqy4KVQDuCXE3puWdFItFhqcE4pVDiFubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gfiJks1c; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gfiJks1c"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uA6h7deZ5T2nPPUM53EJqA3rIZv32XXAgEtZLgQMBOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791781205; v=1; x=1792386005;
 b=gfiJks1c3uh2Km7Or7QC2mEXQKcLJe+cKvsWL5dkXItzK59nByMra/pWd+7KxTOWa9Wjkw/A
 wPNWGbpF/6lPnK1drP9fseMxMkXrMUEr086FZ7LUjOsCcSaUYriC1Z8ViiIPKJP6aU9zzDU9m8I
 8/1QgmaEMf9BiqEr5NgOcY5g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3b5ce599a09242ec;
	Mon, 12 Oct 2026 05:00:05 +0000
X-Mizu-Trace-ID: 3b5ce599a09242ec
X-Migadu-Flow: FLOW_OUT
Message-ID: <229cb94a-6ac5-4c3c-b69d-d32dfca2ff8f@linux.dev>
Date: Mon, 12 Oct 2026 12:59:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address in
 tracing_multi link
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, Jiri Olsa <jolsa@kernel.org>
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

cc Jiri

On 12/10/26 00:48, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> tracing_multi link accepts different BTF ids that resolve to the same
> address. The attach succeeds, the detach fails in ftrace and the kernel
> crashes in freed trampoline images.
> 'test_progs -t tracing_multi' hits it when the kernel is built with
> CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions do
> the same.

Without CONFIG_DEBUG_INFO_BTF_INLINE, the patch 2 selftest also
reproduces the warning.

The fix lgtm.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

