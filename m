Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80947728D
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136611; cv=none; b=YAUyArc+/r3ypoc70VTHQ+JqHLR5bP/uu5U8gM0xsJpw/yuCDrORoO0jyDSAAAGH+d62X/YucLwsoKGlY+xESvfcBJLhcZS+waxGk7U+oe/TAFRfMwnQfzWzeKRmUlpVtxZlYrFlTlHirD2/kejWdKF5BR2PNk3mAt3VOlLOY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136611; c=relaxed/simple;
	bh=uFsxOYrOdHTQhtg3Sm6kZm6vtCvGuf8ATNW88crU00Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7FYM1DGYoyqpCX1AdjZ+2nh8e2TJ/hVYtM0Kv6Ievh0rPD7phP3OuH+WghAbgXtyrd0IyfKgHyCd9jHxLIrK4lHLF2X2wLZSsbSrYdA6aYOzBW3LkbEK/AvkDDEBBkB9/wb3z+WY17FZuqdvUlGnLKR5f8D7J5ZTP52zI9NUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUVywEy/; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUVywEy/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uFsxOYrOdHTQhtg3Sm6kZm6vtCvGuf8ATNW88crU00Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791136603; v=1; x=1791741403;
 b=oUVywEy/eMq/U7wzmkW+TDSkK/ni8lrRQ0OgicjuZ/lzblmBgXtcSXFvFpxbZ28iDKMNePDJ
 kARsNcRybjEXvKATlhY+8RQiprPP3w0RVlisVWMjsRSFUS/wbcAI0azPubKm6czqkW2yOLQf20q
 3Lnw1JCIKLoDcLhSiO+wx+u4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9059b8fb747cf00a;
	Sun, 04 Oct 2026 17:56:43 +0000
X-Mizu-Trace-ID: 9059b8fb747cf00a
X-Migadu-Flow: FLOW_OUT
Message-ID: <7cd2925b-6f3e-4cea-91e4-e0dc3abdf341@linux.dev>
Date: Sun, 4 Oct 2026 19:56:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing
 pad in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133042.1339539-1-yonghong.song@linux.dev>
 <DLV784DBX12N.12EC4LTWZLKXG@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLV784DBX12N.12EC4LTWZLKXG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/3/26 2:23 PM, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>
> in addition to what bpf-ci found...
>
> can we let both kfuncs go through check_kfunc_call(), like bpf_throw()
> does, and follow the unwind after it?
> Then there is nothing to open code here and no need for
> check_kfunc_allowed() and check_kfunc_allowed_only().

Okay, will fix fexit issue and also add bpf_unwind() and bpf_unwind_resume()
inside check_kfunc_call().

>
> pw-bot: cr

