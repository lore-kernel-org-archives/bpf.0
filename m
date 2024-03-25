Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD783A03
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409765; cv=none; b=USmQmt/S/d9pYwve7MuSLhWW9bPKkw74rAjPALavEQ5ZFJsdAQta8z6zvSsFJUET31Vn3drhLtz/3nJBVY6LR7jaNhclAUCxi9721D7VwkkAF3Ibc3wFGUOdhQExtX6gr56q/aGNw5VrDD2o4If9Z4ovgFmcWgzWHMK5B7kwE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409765; c=relaxed/simple;
	bh=B+pK1kUYmF7LD5I9MV7JDqAlGsTwLeCSOGtGRTnkhQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8TSrjEtnniup31qiRQa3BcrrfDVFpoS3Zhrh6+x+siZhKbhy/zS9dtO2JOTc55xMX8S9zgSOovPOYAHIIo+XBUoStQVvRjQIodB07g8N0jWC+ykcOEBuPiLfDNTNE67ouui4TVFb7PzwQfpB9aFIWhuhWg8OL26uVN52ScHyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNg/swKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNg/swKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A59C433F1;
	Mon, 25 Mar 2024 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711409765;
	bh=B+pK1kUYmF7LD5I9MV7JDqAlGsTwLeCSOGtGRTnkhQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TNg/swKao0fimkvqNVlaAMq2FHoWhY3FsOA+pivmfoMBNgXmsSe3vc6lxT5fV2fYZ
	 m8tRCUgLCpxhYGrWtAt59A63VYXjN9AplKzbgNq6tlyfhQYP+3s0toq6ZjIsVLo476
	 98csIYnF3xGG7GWPFfIeNxaCUTKkJpe9osHetVYQCgXQ1mRz1JkG6s3w4J4Q/j70b+
	 vgZ7m228+Wk/L4oofsY0QOs9v8sQq0RjK0LY8cI07Sttz4WfQXgGe/Rt/CW8k1NoKq
	 +gntKL2MAKL+tuccKedKMtc4zAPH5UC3WsW30diKDLwNIAriFl2t+3tjyB7YsZFIxY
	 z/3jpbCUy7vyA==
Message-ID: <c00ec359-a99f-42b7-894a-8e79a7cce888@kernel.org>
Date: Mon, 25 Mar 2024 23:36:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] bpf: improve error message for unsupported
 helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240325152210.377548-1-yatsenko@meta.com>
 <CAEf4Bzb_3d=+PfaBFCDDOSnU3jwb_W1BaVkgZsF-UcVefysOOg@mail.gmail.com>
Content-Language: en-GB
From: Quentin Monnet <qmo@kernel.org>
In-Reply-To: <CAEf4Bzb_3d=+PfaBFCDDOSnU3jwb_W1BaVkgZsF-UcVefysOOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/03/2024 23:19, Andrii Nakryiko wrote:
> On Mon, Mar 25, 2024 at 8:22 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> BPF verifier emits "unknown func" message when given BPF program type
>> does not support BPF helper. This message may be confusing for users, as
>> important context that helper is unknown only to current program type is
>> not provided.
>>
>> This patch changes message to "program of this type cannot use helper "
>> and aligns dependent code in libbpf and tests. Any suggestions on
>> improving/changing this message are welcome.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> 
> "unknown func bpf_somehelper" is one of the common confusions users
> run into (and I had to explain multiple times), so this more
> meaningful message is definitely an improvement, thanks!
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Same here; and thanks for including the bpftool update!

Acked-by: Quentin Monnet <qmo@kernel.org>
