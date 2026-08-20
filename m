Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716E389453
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259692; cv=none; b=uDAP0XxhGb/lMj4jMXgk4qR06LdUu2xH0E9nS8Glk1hjbipfFtbd9p18mEwKaKjprs70kVFRLB78QSrwAhD6hYpkxyR5FxbP4gUQsV8VHQ5s+KdwkOmIjQJ0Qu7cgW8AZjadF5BnMSlAGL54M0fCjUlzJD6ygo/DtrbWV8o6bP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259692; c=relaxed/simple;
	bh=wCS2DD8J6nLqi53I7Pwtai0YA5UgWg8nOyzsQOiDRfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s09msIfElKgNaxJ1Mn+hf35dOG4fFMQvYAc3auPat44VuPn8YHz4Al4wdiSpJoLZYnAebBGMcIuAMVIxiEPyGxIJjsVY8qEFGdjV8ufVbnADy4pU2VRhEOpZLaaMFe2V1lRt8J71JG2xVqqU8Gc6lH9Rrjax6+lGokIE4E1M0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Li0tWw9Y; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Li0tWw9Y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wCS2DD8J6nLqi53I7Pwtai0YA5UgWg8nOyzsQOiDRfc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787259686; v=1; x=1787864486;
 b=Li0tWw9Yu2/xOITZ6kQ2y0BMok+234plRAtYr4ZNG66K71rigCzfmyvOTYsZGq0QLlSe+sVb
 VcE/AvgAU3fKyFJAXppMKZ9RiUSUOo6sXuXhIREMxo4SX262lYgtsVytlkjISYcRrH53DyTlyHW
 F7Le+9ZC986qXg9t/elsA0n4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21cf::13e0] (2620:10d:c090:400::5:2133)
	by smtp.migadu.com with ESMTPS id 547aabd8a36d0cad;
	Thu, 20 Aug 2026 21:01:26 +0000
X-Mizu-Trace-ID: 547aabd8a36d0cad
X-Migadu-Flow: FLOW_OUT
Message-ID: <6d4f9d4f-b537-4ec9-8f15-18775fc93242@linux.dev>
Date: Thu, 20 Aug 2026 14:01:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool btf
 dump format c
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
 <20260820000627.3826188-3-ihor.solodrai@linux.dev>
 <186766fa22a79cfbdf72ee51494004e91cccebee.camel@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <186766fa22a79cfbdf72ee51494004e91cccebee.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-20 12:09 p.m., Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
>> "bpftool btf dump format c" generates the vmlinux.h that BPF programs
>> are built against, and it has no test coverage at all. The only
>> in-tree consumers are build systems, and none of them diff the result.
>>
>> Building against the header only catches what a compiler rejects.
>> Missing macros, a missing preserve_access_index pragma and the wrong
>> padding width all compile.
>>
>> Add a test for those three, over both sort orderings.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>   .../bpf/prog_tests/bpftool_btf_dump.c         | 151 ++++++++++++++++++
>>   1 file changed, 151 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
>> new file mode 100644
>> index 000000000000..53bb7065b3ca
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
>> @@ -0,0 +1,151 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <bpftool_helpers.h>
>> +#include <bpf/btf.h>
>> +#include <unistd.h>
>> +
>> +#define DUMP_BUF_SZ	(16 * 1024)
>> +
>> +static int btf_to_tmpfile(struct btf *btf, char *path, size_t path_sz)
> 
> Nit: let's drop path_sz and assume PATH_MAX.
> 
>> [...]
>> +static struct btf *mk_btf(void)
>> +{
>> +	struct btf *btf;
>> +	int id, err;
>> +
>> +	btf = btf__new_empty();
>> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
>> +		return NULL;
>> +
>> +	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>> +	if (!ASSERT_EQ(id, 1, "int"))
>> +		goto err_out;
>> +
>> +	id = btf__add_int(btf, "long int", 4, BTF_INT_SIGNED);
>> +	if (!ASSERT_GT(id, 0, "long"))
>> +		goto err_out;
>> +
>> +	id = btf__add_struct(btf, "holey", 16);
>> +	if (!ASSERT_GT(id, 0, "struct_holey"))
>> +		goto err_out;
>> +
>> +	err = btf__add_field(btf, "c", 1, 0, 0);
>> +	if (!ASSERT_OK(err, "holey_c"))
>> +		goto err_out;
>> +
>> +	err = btf__add_field(btf, "tail", 1, 96, 0);
>> +	if (!ASSERT_OK(err, "holey_tail"))
>> +		goto err_out;
>> +
>> +	btf__set_pointer_size(btf, 4);
> 
> Nit: I think the approach taken by btf_distill.c:test_distilled_base()
>       is a bit better, it drops verbose error checks after each btf__*
>       constructor call and calls VALIDATE_RAW_BTF() instead.
>       This is both concise and self-documenting.

Wasn't aware of that one. Will try it, thanks.

> 
>> +
>> +	return btf;
>> +err_out:
>> +	btf__free(btf);
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Check only what the selftests build cannot:
>> + *   - bpf_helpers.h defines __ksym and __weak as well, and no program uses
>> + *     __bpf_fastcall, so losing the macro block changes nothing;
> 
> The above bullet point does not make sense.
> 
>> + *   - building without the preserve_access_index pragma is a supported mode
>> + *     (BPF_NO_PRESERVE_ACCESS_INDEX), so losing it only costs CO-RE;
>> + *   - the padding width comes from the BTF's pointer size, and a native build
>> + *     never runs the host bpftool over a differently sized target's BTF.
> 
> Please make these two inline with actual asserts,
> also "... so losing it only costs CO-RE" is completely out of context here.

This block made sense to me yesterday.
I was either too "in context" or too tired. Will fix.

> 
>> [...]
