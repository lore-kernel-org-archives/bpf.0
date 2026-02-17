Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C13358D9;
	Tue, 17 Feb 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330640; cv=none; b=R7yZ71NFLnD5uuZ3o3QHO4StsUEq2SILhopGWgrL8xv9LfTcZV9I7bOExaMi2E3ybUEt76HPmAQCkQc1045eR7vgqJKBJaHTSw43ujNVoXfy9108I5iEtFglXIU+nWjFOBxBz1WF/vm+zBP3ngMXRIuBsl73534fEJjQ6q19RN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330640; c=relaxed/simple;
	bh=e0cHAqU90q7/WazEyUD2sLvvYCwGwWOq5gql4NLnS9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2olDDiyP0Dx0GyCEyBG3lgGOH0gxASDjcyDhxYkmBuAHl+sasMJn2BZO6dNcdIXk0XV8CofJSjy7NCo4YCCLJNv661aaCVCrdclx6UqJXaglbw+Z6Yo/FnJGZUYmcb1CCu0SaeKasodCHznUPOjjQijZCqq4PD3iuIvEVX/SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDRm9rzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDRm9rzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD5C4CEF7;
	Tue, 17 Feb 2026 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330640;
	bh=e0cHAqU90q7/WazEyUD2sLvvYCwGwWOq5gql4NLnS9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iDRm9rzxaK1Z/2FZYkR+Ic2+fbZ60GSAqkH0gTn8JGxT/dncahalwWAfA2IYZY3WK
	 tkj4PD5cXzNB63HD0QhR9f1OGJzV+NoBtHGVVJ5ehm3FZSE6F9B9i/d/9DkkNnREWg
	 aG8uoWC7oROjaHASVIJeQyzTM5wK1nsaPnkC9SN1hqLvIjZ8mAGzea+hZLgQ+eVVnV
	 tDKrbVEPwk29nMRaiMDxEqRQE9HFh9Si7tSNOGlTLIAsR40vBrCzK2qto0V8z3Fqcr
	 LoKXeJgDo2MWxmcbBP5cGcPpIylBO9sVvGUJVuxrBzEYX+I4eLpC5qes1UMgzrZUvv
	 vILuI7loCCgMA==
Message-ID: <76b4511d-b541-4e67-a16d-4615c36f1f09@kernel.org>
Date: Tue, 17 Feb 2026 13:17:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf] selftests/bpf: Remove hexdump dependency
Content-Language: en-GB, fr-BE
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260216-bpf-sft-hexdump-od-v1-1-f8cebd8eb9d0@kernel.org>
 <20260217112944.75610d2b@pumpkin>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260217112944.75610d2b@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thank you for the review!

On 17/02/2026 12:29, David Laight wrote:
> On Mon, 16 Feb 2026 17:30:34 +0100
> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:
> 
>> The verification signature header generation requires converting a
>> binary certificate to a C array. Previously this only worked with xxd,
>> and a switch to hexdump has been done in commit b640d556a2b3
>> ("selftests/bpf: Remove xxd util dependency").
>>
>> hexdump is a more common utility program, yet it might not be installed
>> by default. When it is not installed, BPF selftests build without
>> errors, but tests_progs is unusable: it exits with the 255 code and
>> without any error messages. When manually reproducing the issue, it is
>> not too hard to find out that the generated verification_cert.h file is
>> incorrect, but that's time consuming. When digging the BPF selftests
>> build logs, this line can be seen amongst thousands others, but ignored:
>>
>>   /bin/sh: 2: hexdump: not found
>>
>> Here, od is used with awk, instead of hexdump with sed. od is coming
>> from the core utils package, and this new od command produces the same
>> output when using od from GNU coreutils, uutils, and even busybox. This
>> is more portable, and it produces the same results as what was done
>> before with hexdump (without trailing whitespaces as a bonus).
>>
>> Fixes: b640d556a2b3 ("selftests/bpf: Remove xxd util dependency")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Originally, I was going to add a check to stop the build if hexdump was
>> not available, but switching to 'od' seems to be a better solution while
>> not adding a new dependency.
>>
>> Because test_progs was not reporting why it became unusable, I added a
>> Fixes tag to have this backported, to help others. Feel free to remove
>> it, or even drop the patch if you prefer to stick with hexdump.
>> ---
>>  tools/testing/selftests/bpf/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index c6bf4dfb1495..5a618d14243e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -723,7 +723,7 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>>  # Generates a header with C array declaration, containing test_progs_verification_cert bytes
>>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>>  	$(Q)(echo "unsigned char test_progs_verification_cert[] = {"; \
>> -	 hexdump -v -e '12/1 "  0x%02x," "\n"' $< | sed 's/0x  ,//g; $$s/,$$//'; \
>> +	 od -v -t 'xC' -w12 $< | awk 'NF > 1 {for (i=2; i<=NF; i++) { printf "  0x%s,", $$i }; printf "\n"}'; \
> 
> That is subtly different.
> The hexdump version deletes the final ',' from the last full line.
> But not a partial line because there are trailing spaces (from before
> the '0x  ,' that get removed).

Good catch!

> That may not matter, it is valid C, but not C++ (unless they've changed
> the rules recently).
Is it an issue here? From what I see, this verification_cert.h file is
only used in test_progs.c.

> od could be used with:
> 	sed -e 's/ /,  0x/g; s/$/,/; s/^[0-7]*,//'
> which outputs an empty line as well as the trailing ','.

If adding an extra empty line is not a "visual" issue, I'm happy to
change to this shorter sed command if preferred!

> Both removable with a more complex command line.

Indeed. But if they don't cause issues, no need to remove them, right?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

