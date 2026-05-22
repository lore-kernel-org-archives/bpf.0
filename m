Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A33A6B9E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437146; cv=none; b=jzK1SIEjWw+VHx24WJwV2QwYydqnT8Rj7z5G3hcA+J+CBIUJYXpMjvAIdo6K7PNn+YQhJKMyj5oIz6lWGOZPGIEammm2BbIi3Sb8vqcyabY0uHTtrkWcRYsn/6QN8vaLlmCd7rmCAtPRap6xEUrOrX420TIGIaMyxmLqNPoDaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437146; c=relaxed/simple;
	bh=Za0UnAfhljyxTgaHkwBFPdTupiRi5wZYqL9Bg7XJf2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XqP19CdBGmfzAeuL9vt0nkkeTazu1PXoKgyYaRRXRzxR1yib9x+Zpat0acGQ/FoGiHzG4npC9z9yc61nO5Bg7f4FsKdx5mwzzfcLqlDEINtOOpSCli/lwfMEoWgwYo40a+lPtbGgtVO1AB5/OJI9khAMt56Tpc3dSgZLM/OzUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoPsndTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoPsndTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47801F000E9;
	Fri, 22 May 2026 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779437144;
	bh=XJq4fFitJjpZFILdTRp3fY0Wr3O6hJ6C3AEZwWWRsO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoPsndTxW2QzzNdqgNLEKewA47i8bzFswKtViygCIQq3G0xPzKkqy72MyYUrkicED
	 E1lrCyzcwT0jws8hmmLYSmLQNQX2bMXI663FvF7k3MWEdvAo+zaJE80uDglHubMPhg
	 B1APDWHcX8qQ0UVtyZrxnjoTTVBI7D81xg0cZMMqo5Z2Y901cX7o4BjxLRtK6NpM0/
	 O4yWsV5BzpYUvnypR++o/hlB8q2T/m6WUym/0vQ43ACS/AE4blY3k9NBPDs1WuUBtB
	 dc55+xAC4MNYG3Byxh+GrhnwOiHfiXSWUAPUygxJ7ktRs+1TNqBgRXmC8LCskLUDxw
	 dZUZPOv3kaCsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/11] selftest: bpf: Use
 BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522074601.1658705-2-kuniyu@google.com>
References: <20260522074601.1658705-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 08:05:44 +0000
Message-Id: <20260522080544.B47801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Deriving an invalid bitmask using `BPF_SOCK_OPS_ALL_CB_FLAGS + 1=
` is mathematically brittle and breaks binary forward compatibility.
--

commit c1e093a27fd28a0f7083a5bd0002abbedd3222a2
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.

This commit replaces a hard-coded 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1
to test the failure path of bpf_sock_ops_cb_flags_set() in BPF selftests.

> diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools=
/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  		break;
>  	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
>  		/* Test failure to set largest cb flag (assumes not defined) */
> -		global.bad_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops, 0x80);
> +		global.bad_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops,
> +								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);

[Severity: Medium]
Is using BPF_SOCK_OPS_ALL_CB_FLAGS + 1 mathematically brittle here?

If BPF_SOCK_OPS_ALL_CB_FLAGS is not a contiguous sequence of bits starting
from bit 0 (for example, if a flag is ever skipped or deprecated), this
addition might create a value that overlaps with valid bits. The helper
would clear the overlapping valid bits and return a smaller value, which
would falsely fail the test.

Also, could this approach break BPF CO-RE binary forward compatibility?

If a test compiled against older headers hardcodes the old
BPF_SOCK_OPS_ALL_CB_FLAGS + 1 value into the BPF object, and runs on a newer
kernel that implements that bit as a valid flag, the kernel will accept the
flag and return 0 instead of the expected failure value.

Would using a statically unassigned high-order bit (e.g., 1 << 30) be a
more robust way to test this failure path?

>  		/* Set callback */
>  		global.good_cb_test_rv =3D bpf_sock_ops_cb_flags_set(skops,
>  						 BPF_SOCK_OPS_STATE_CB_FLAG);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools=
/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
>  	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
>  	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
>  	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
> -	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
> +	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
> +		  "bad_cb_test_rv");
>  	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
>  	ASSERT_EQ(result->num_listen, 1, "num_listen");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.1658=
705-1-kuniyu@google.com?part=3D1
