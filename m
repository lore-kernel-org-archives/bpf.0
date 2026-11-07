Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019661;
	b=UsavpOZ5JcO3xfhRguHQatTAMUyad2TBccKP9V0QoFFblaHotmYOkmdSLUUMUD2zshWQ
	 b68ZbTd4WCLUnZs50IqP8aQAQLL6eQlIrmWY4zmtuoJD9PRt7AxMIBT6qwgfL0ELYum+O
	 Ifuavgq9g7w0f3Lq+OfWE9b0jsT4L8k/dBRWle7vdcXjdXsqldrEkHhUIbevcSk11eoFe
	 zwvn7MgaezP7I7h2NBJy87H/+S76ADJOm+Qk5Tp/UJY6jM1+Yku4O1QHfbIvYYJwO1JB+
	 kRW/0F6JXBGFTBonEfEBolBEkHf5XxYpdS6U/55Z3U0N9+MrxYHpatW90Cd/fZNDt/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019661;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tT62JfT4hQHGP/AW1QdzzQoq0p5KaNWuEo556/tSKYk=;
	b=w7jmHvp8NFdAoukJUVZRtkHqlrIx4c7mJFYxJIWpbYnxfbrlqTPlviqOjbiE4C2qwcsy
	 xkUdMNM7O1qrmdTox0q9j4GTzOn/L/LV4grGOqwtKKj852a2/sSQqcmXKNLrifnDWgN2U
	 DrMzPpxhW6udV59pEO2BA/aaNT9bh1k1ExoFviLoup9CFnkA3e3xaw4+nHCKPuaZLhOec
	 vf096Ar4I0r8BfsLe0dtu2Q2sE2RT0wtYJTbcQEys0KBM1l3sY+fuoamPTBXluCA8QOQe
	 ttbth4n1Z2As73/ikKKWPu3GnOXF9bRtaB9hgPLVg++vyBcpdlj37aNlMr6i1VYw34A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbqICgbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C2606A326;
	Sat,  7 Nov 2026 02:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbqICgbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58501F008A1;
	Sat,  7 Nov 2026 02:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794019661;
	bh=tT62JfT4hQHGP/AW1QdzzQoq0p5KaNWuEo556/tSKYk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GbqICgbJCKIrlAOBvtaBwMdvdRD6lY+lOJMrouVF8M6r381PGh0q6MXevli9kvWlK
	 LFtL/xMEcrMdlG3BiJSLytTx5xYiaYu54u6Ru6O5rUGdEJ6ousGB/5MxdJ0pIYzFo3
	 zPReBdADLnhvPZFwsVPs1adFWa4S9fGxdHG2k/t0ASH7QP3jY+Y7ocRUqH0my3osV7
	 fZ2OeqOZhkb8HezlbDplGEhDGlqUAS5uDVChVzzjlbrq23lPOnh6LT5ArfYsjoUlr4
	 R/wjEZdV2sIuxcFGngv2INru6uMgy/T+3rC8jSDhHev42tYJ8CH/fpf+RTzAxKXnYs
	 E28RkEdyMQlow==
Content-Type: multipart/mixed; boundary="===============8730462656901357163=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d190f90d01988652195bf5ced90396d7ad07425705bd274d73140016d6a6c129@mail.kernel.org>
In-Reply-To: <20261107020725.36675-4-dennylin0707@gmail.com>
References: <20261107020725.36675-4-dennylin0707@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Cover enum signedness in data dumps and map fields
From: bot+bpf-ci@kernel.org
To: dennylin0707@gmail.com,ast@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,qmo@kernel.org,daniel@iogearbox.net,yonghong.song@linux.dev,eddyz87@gmail.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,dennylin0707@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 02:47:40 +0000 (UTC)

--===============8730462656901357163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover enum signedness in data dumps and map fields

TL;DR: The wide_unknown btf_dump test only checks for digits, so it may pass
even when libbpf prints a truncated 32-bit value; a possible crash on 32-bit
hosts is also raised.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c

[ ... ]

> +static void test_btf_dump_enum_values(void)
> +{

[ ... ]

> +		/*
> +		 * Wider data must not match an enumerator through its low 32 bits.
> +		 * Check numeric output without requiring an exact value.
> +		 */
> +		{ "wide_unknown", 8, 0xffffffffLL,
> +		  { .u64 = 0x1ffffffffULL }, NULL },
> +	};

[ ... ]

> +		if (cases[i].expected) {
> +			ASSERT_STREQ(str, cases[i].expected, cases[i].name);
> +		} else {
> +			ASSERT_NEQ(str[0], '\0', cases[i].name);
> +			ASSERT_EQ(strspn(str, "0123456789"), strlen(str),
> +				  cases[i].name);
> +		}

Does the wide_unknown case actually guard against the low 32 bits being
shown?

The check only requires the output to consist of digits, which also
passes when libbpf prints the truncated value.  In btf_dump_enum_data()
the fallback for an unmatched BTF_KIND_ENUM value is:

    __s64 value;
    ...
    btf_dump_type_values(d, is_signed ? "%d" : "%u", value);

The value is an __s64 but the format is %d or %u.  For an 8-byte enum
holding 0x1ffffffff, x86-64 would print "4294967295", which is the low 32
bits and equals the VALUE enumerator (0xffffffff).  That is the situation
the comment and the commit message say this case guards against, yet the
test passes.

The bpftool counterpart (enum_wide_unknown in bpftool_map_dump.c) requires
"8589934591", and passes because btf_dumper_enum() uses jsonw_uint() with
a __u64.

On 32-bit hosts the 64-bit argument takes two vararg slots, so the high
word would be consumed as the char * for the "%s" appended by
btf_dump_type_values().  Could that crash test_progs in this subtest?

Related, in existing code: the macro expands to

    is_signed ? "%d" : "%u" "%s%s"

so string literal concatenation applies only to the unsigned branch, and
signed unmatched values (and the ENUM64 "%lldLL" branch) are printed
without the delimiter and newline.  This was not introduced here; it
dates from d90ec262b35b ("libbpf: Add enum64 support for btf_dump").

Would it make sense to have the libbpf fallback print a 64-bit value (for
example separate %lld/%llu calls with a long long cast) so that this case
can require "8589934591" as the bpftool test does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42329238242
--===============8730462656901357163==--
