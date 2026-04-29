Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B83E5EE3;
	Wed, 29 Apr 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468428; cv=none; b=qO5774b8eV6XlFivAr9o/uFLnbm0xFpEmcMaD3vr4iBj66RyQSnk1C/5n2H+Mbgls6sqI6y7/b5dVpbE+gy3nfJEmyyrZHrn+LWh5pc+7d3sXTxMwHYb92UnplZoM6kW+z/+d85myoTHI2FDzW6CCpM3FKyFfz6J3TBjCcFWY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468428; c=relaxed/simple;
	bh=xyApZhQkCvbHWHOjfk01Mlkja0YuP3x8DbeSYtOGQaI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S4YIUjiIxy894jBdy8aWhKA288hM9pwtnI5zHxtYU+zt3LQLEnzo5tSj6QkNY2LkTs3EITYGyC+4/VyoVotbJXK5r4Vt8snBQuD4jDZBtfyw/r+InhKbCKz9/jYeWpAba+HO8paxv+ZD+c4FOHroqpXwwsZTdgXedQvChUCdtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSVkBWX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSVkBWX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EC7C19425;
	Wed, 29 Apr 2026 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468427;
	bh=xyApZhQkCvbHWHOjfk01Mlkja0YuP3x8DbeSYtOGQaI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MSVkBWX5LZbmTgMMEMGCDHEu1FjqTdKvhxmDGtrfiZW+vGV+fKFg7t3+rxbY+HtnF
	 d73g2dt8G5vCh4InKfpfhl1dnCncDaSHsOoPsUG9KRLa8QLlKcJTGO2lVTz6j+WjFt
	 /TadBQHXBKESfQp3qNylx+nD1qg13V1q9q+16pHyGAtPwAi4hxTe66OjaHDpBWpmO9
	 GBOuOSNsnpn0SDxjJHD4Y6+0+O6cZ5G4pZ2J4D6DGNLQYtFjzCJj2bKM7kyBZrKgFG
	 jADI85cE+3oLAMWH1pVHPWmHucYR6eHW0VjfFWfSeoxOMee19lhFa7tMF25wfH6u0M
	 hF+0CmYgW9AaA==
Content-Type: multipart/mixed; boundary="===============4912663236239402681=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08d719aae85f9fdcb1e718f940502f9008cc7edb71e51f4fb3164cbfe8fa5d53@mail.kernel.org>
In-Reply-To: <20260429123543.61559-1-basbunarhasan@gmail.com>
References: <20260429123543.61559-1-basbunarhasan@gmail.com>
Subject: Re: [PATCH v3] bpf: bpf_dbg: split pcap_next_pkt() validation/advance, fix off-by-one in cmd_select
From: bot+bpf-ci@kernel.org
To: basbunarhasan@gmail.com,daniel@iogearbox.net
Cc: ast@kernel.org,andrii@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,basbunarhasan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 13:13:47 +0000 (UTC)

--===============4912663236239402681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
> --- a/tools/bpf/bpf_dbg.c
> +++ b/tools/bpf/bpf_dbg.c
> @@ -918,21 +918,30 @@ static struct pcap_pkthdr *pcap_curr_pkt(void)
>  	return (void *) pcap_ptr_va_curr;
>  }
>
> -static bool pcap_next_pkt(void)
> +static bool pcap_curr_pkt_valid(void)
>  {
>  	struct pcap_pkthdr *hdr = pcap_curr_pkt();
>
>  	if (pcap_ptr_va_curr + sizeof(*hdr) -
> -	    pcap_ptr_va_start >= pcap_map_size)
> +	    pcap_ptr_va_start > pcap_map_size)
>  		return false;
>  	if (hdr->caplen == 0 || hdr->len == 0 || hdr->caplen > hdr->len)
>  		return false;
>  	if (pcap_ptr_va_curr + sizeof(*hdr) + hdr->caplen -
> -	    pcap_ptr_va_start >= pcap_map_size)
> +	    pcap_ptr_va_start > pcap_map_size)
>  		return false;
> +	return true;
> +}
>
> +static bool pcap_next_pkt(void)
> +{
> +	struct pcap_pkthdr *hdr;
> +
> +	if (!pcap_curr_pkt_valid())
> +		return false;
> +	hdr = pcap_curr_pkt();
>  	pcap_ptr_va_curr += (sizeof(*hdr) + hdr->caplen);
> -	return true;
> +	return pcap_curr_pkt_valid();
>  }
>
>  static void pcap_reset_pkt(void)
> @@ -1143,7 +1152,7 @@ static int cmd_select(char *num)
>
>  	for (i = 0; i < which && (have_next = pcap_next_pkt()); i++)
>  		/* noop */;
> -	if (!have_next || pcap_curr_pkt() == NULL) {
> +	if (!have_next || !pcap_curr_pkt_valid()) {

The commit message asserts that after this fix, 'select K shows packet K
for all K in 1..N' and 'select N+1 correctly errors with no packet #N+1
available!'. Does the actual code achieve this behavior given that the
loop still initializes i to 0?

With the new pcap_next_pkt() semantics (validate-current, advance,
validate-new), trace through 'select 1' on a file with >=2 packets:

  Iteration 1 (i=0):
    pcap_next_pkt() validates pkt1 (ok)
    advances cursor to pkt2
    validates pkt2 (ok)
    returns true
    i becomes 1

  Loop exit (i=1, i<1 is false)

  Cursor is now on pkt2
  pcap_curr_pkt_valid() returns true
  Function returns CMD_OK

The user requested packet 1, but subsequent 'step' or 'run' operates on
pkt2. This reproduces the exact defect the commit claims to fix: 'Before
this fix, select 1 shows packet 2's payload.'

Similarly, trace 'select 3' on a file with exactly 3 packets:

  Iteration 1 (i=0): advances pkt1 -> pkt2, validates pkt2 (ok), i=1
  Iteration 2 (i=1): advances pkt2 -> pkt3, validates pkt3 (ok), i=2
  Iteration 3 (i=2): pkt3 valid, advances past pkt3 (cursor at EOF),
                     post-advance pcap_curr_pkt_valid() is false,
                     pcap_next_pkt() returns false, have_next=false

  Loop exits with have_next=false
  Code hits 'no packet #3 available!' even though packet 3 exists

The commit message itself identifies the correct fix: "Simply changing the
loop init to 'i = 1' (so it advances N-1 times) fixes the user-visible
symptom". That change was not applied in the diff. The loop still uses
'i = 0', which causes it to advance N times instead of N-1 times, landing
on packet N+1 when the user requested packet N.

The v3 patch discussion on lore.kernel.org/bpf addressed this by changing
the loop from 'for (i = 0; i < which ...)' to 'for (i = 1; i < which ...)'
to properly implement 1-based indexing. The current code has the
pcap_curr_pkt_valid() refactoring but is missing the loop initialization
fix.

Reference: https://lore.kernel.org/bpf/20260429123543.61559-1-basbunarhasan@gmail.com/

>  		rl_printf("no packet #%u available!\n", which);
>  		pcap_reset_pkt();
>  		return CMD_ERR;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25109638113
--===============4912663236239402681==--
