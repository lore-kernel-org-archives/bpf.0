Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C95B21A;
	Sun,  6 Sep 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703008; cv=none; b=p4GEUBVnvSRyD860WELz3wUQ/Kttujs5faR963fzln33Jdoe7e2mQc2BIRhtlX66qWHA4kDTmJ13fCPZkQjio1FT6a/F5xsSeuKrV/lSFX+THnW4yE8pnNnzgtvvUyV4Oh6EXS4coBXeSReQ9xBm2k70hW7qCl1XcD+Y+6bWFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703008; c=relaxed/simple;
	bh=vb5ltAB6HXEirqVV/IKzVOZrN5l5GeUIZevMJsER5J8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJjmGOijQnsR07CrY0s86MyizztxpCPqAZnzaw5JGichJF32ivBRmU59WfBvRRmhkPT4ymO0WMgf3KJD/b4mQK9Ui9mxLpqxdGmi0G1d31lJsG1qhTh7xnqKpOrlazwrMz7CJgXkWI9ej92cqA3cE+FRz4EwKxrf2GO0I3CvjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9gvx7RZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9gvx7RZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C321D1F00A3A;
	Sun,  6 Sep 2026 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788703007;
	bh=vb5ltAB6HXEirqVV/IKzVOZrN5l5GeUIZevMJsER5J8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=I9gvx7RZdcixzco1WFo5Vq90ErkRkPAlXKvHA2DZWu/4vr2clOmnW0LFgoMbK5m3L
	 qwdACvpi85TbHApA7/CeIw/bDveGMcqR9kYIytBHliNspg4hX0ir/n/gvF1as0JPP2
	 I8NJ8SCC4z+MfxKHEsWub2zkWJ6Qkor5Y6ghgSNP6NQ/yCfmnoIoZFOoijMDcQXgUd
	 N/TguHwmoI3Ov1EmBpy5W3uDFDiFJaVik88jIQJVp8sj2zjyEqWyzU8RoYVNl8o6pP
	 yty3Kdgkh+hsYkFwSPQhn3uZyKPZBLl3iFL2PfNDsq/uBJcXWRczdbFUJMkwzbqUYQ
	 3wW4nu9ne/1HQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, stfomichev@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com, andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
In-Reply-To: <apBHXkxgq3XNEEy4@boxer>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
 <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
 <20260820104419.050cbc44@kernel.org> <aoc+/OW8Gy4ZOx+w@boxer>
 <20260820142920.6c96ec67@kernel.org> <apBHXkxgq3XNEEy4@boxer>
Date: Sun, 06 Sep 2026 15:56:41 +0200
Message-ID: <878q5epjom.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Thu, Aug 20, 2026 at 02:29:20PM -0700, Jakub Kicinski wrote:
>> On Thu, 20 Aug 2026 19:53:00 +0200 Maciej Fijalkowski wrote:
>> > On Thu, Aug 20, 2026 at 10:44:19AM -0700, Jakub Kicinski wrote:
>> > > On Thu, 20 Aug 2026 11:35:53 +0200 Paolo Abeni wrote:=20=20
>> > > > ## Form letter - net-next-closed=20=20
>> > >=20
>> > > these are bpf patches. Tushar, tools/testing/selftests/bpf is BPF=20=
=20
>> >=20
>> > But AF_XDP is now net target since some time. Should we move the test
>> > suite out of bpf directory then?
>>=20
>> True.. but until the move happens it feels a little awkward
>> taking pure ksft/bpf patches via net-next?
>
> CC: Bjorn
>
> We had a talk about potential next steps and what would take to get this
> test suite executed against HW tests. tl;dr version is that some of the
> work is needed to adjust it from infrastructure POV as currently
> xskxceiver runs as a single process with two separate threads and what
> Bjorn was saying we will rather be needing two standalone processes that
> could be used on DUT and packet generator.

Yeah, that matches what I had in mind -- for HW tests, the two endpoints
need to be independently runnable processes. One runs on the DUT, and
the other on the peer/traffic generator. IOW, the existing tool needs to
support such a setup, which is a move awway from the two-thread setup.

I'm still not convinced that this would be this tool, or something else
(new).

Again, restructuring is definitely a follow-up, and should not block the
shared-UMEM work. Also, the move from selftest/bpf can also be handled
separately.


Bj=C3=B6rn


