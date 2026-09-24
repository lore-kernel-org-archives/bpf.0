Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4830D3E0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266335; cv=none; b=XJk3017P7zCR2kcrNfasWNLrUVnIEmLt5NXZN+VF7N74pm0tvOg8A89+8rAQOJ4vISDrf3wsfdvR6DrRcb2lxCa3isEJjttoB29nRdzA3qw+kqqzfuxStohpTpTOys5IUdWG5UZwEzUOarHrVmc02SbgOgkZONcAtF3dLUzu23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266335; c=relaxed/simple;
	bh=Vea53w4EejSjq+kT9Ps3RZlh+GYWjMqH6GTQQitn++E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQIJpYxjBd455YE+WENTr45OaJjxGZO2ZG1aivi8NCjZQQO5mmOKLxb49xzEnpwJENmCAOBIWujIVYEMtUvZal3sQawKxeKeFWsVmBJI8LlvyJhUD3ziuUazdV9XWcEuRNKYZvlt/3cSRYxEfO6iSNl7WF+UV1ZAfMSbwMC6bDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iiPgwXI9; arc=none smtp.client-ip=95.215.58.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iiPgwXI9"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vea53w4EejSjq+kT9Ps3RZlh+GYWjMqH6GTQQitn++E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790266331; v=1; x=1790871131;
 b=iiPgwXI9rakEuN0dhDcqlPp5Fs0lignVuhIQOEJnjUAVOeBype8k/eVjqUSpFMl7fxNhYewJ
 VMjuiYT2f5BmCpZKGr04+Z0W8XcfhPkAeT5/mVsar4sFzvDQZeDm7uLmEibXkOv8JKXjwxd0s5A
 z9kHIzvLqvBKGKN1nYhxObIY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 08ef9eb8afe2fe83;
	Thu, 24 Sep 2026 16:12:10 +0000
X-Mizu-Trace-ID: 08ef9eb8afe2fe83
X-Migadu-Flow: FLOW_OUT
Message-ID: <a5289901-6eff-4c0e-baad-9351817592a1@linux.dev>
Date: Thu, 24 Sep 2026 09:12:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <arUZ_0CU-Zlct_Tt@sirena.org.uk>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <arUZ_0CU-Zlct_Tt@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 5:39 AM, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   tools/testing/selftests/bpf/prog_tests/cb_refs.c
> 
> between commit:
> 
>   04ae4ffc57a6b ("selftests/bpf: Check callback map value lock identity")
> 
> from the bpf tree and commit:
> 
>   11300f54bd887 ("selftests/bpf: Refactor cb_refs selftests")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> (deleted the file, which probably lost the test)

Hi Mark.

I submitted 11300f54bd887 ("selftests/bpf: Refactor cb_refs selftests")
yesterday to address a non-code conflict between bpf and bpf-next. A
test would start failing after bpf is merged into bpf-next.

Deleting tools/testing/selftests/bpf/prog_tests/cb_refs.c is correct,
the tests were moved.

Thank you for resolving this.
