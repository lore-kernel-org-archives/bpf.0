Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C856AC10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 23:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6D22077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfDVXrO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:47:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:43328 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfDVXrO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 19:47:14 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIieV-00052e-SM; Tue, 23 Apr 2019 01:47:11 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hIieV-0000N2-GY; Tue, 23 Apr 2019 01:47:11 +0200
Subject: Re: [PATCH bpf v2 1/2] bpf: mark registers as safe or unknown in all
 frames
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <cover.1555957346.git.paul.chaignon@orange.com>
 <d2c281e7a9a8011d5890103c15be5fdd2d2c7864.1555957346.git.paul.chaignon@orange.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6eb840f9-edd6-5bab-b824-75f35b5bca3b@iogearbox.net>
Date:   Tue, 23 Apr 2019 01:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <d2c281e7a9a8011d5890103c15be5fdd2d2c7864.1555957346.git.paul.chaignon@orange.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25427/Mon Apr 22 09:56:03 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/22/2019 08:34 PM, Paul Chaignon wrote:
> In case of a null check on a pointer inside a subprog, we should mark all
> registers with this pointer as either safe or unknown, in both the current
> and previous frames.  Currently, only spilled registers and registers in
> the current frame are marked.  This patch also marks registers in previous
> frames.
> 
> A good reproducer looks as follow:
> 
> 1: ptr = bpf_map_lookup_elem(map, &key);
> 2: ret = subprog(ptr) {
> 3:   return ptr != NULL;
> 4: }
> 5: if (ret)
> 6:   value = *ptr;
> 
> With the above, the verifier will complain on line 6 because it sees ptr
> as map_value_or_null despite the null check in subprog 1.
> 
> Note that this patch fixes another resulting bug when using
> bpf_sk_release():
> 
> 1: sk = bpf_sk_lookup_tcp(...);
> 2: subprog(sk) {
> 3:   if (sk)
> 4:     bpf_sk_release(sk);
> 5: }
> 6: if (!sk)
> 7:   return 0;
> 8: return 1;
> 
> In the above, mark_ptr_or_null_regs will warn on line 6 because it will
> try to free the reference state, even though it was already freed on
> line 3.
> 
> Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db301e9b5295..777970d8c245 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4876,11 +4876,11 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
>  		 */
>  		WARN_ON_ONCE(release_reference_state(state, id));
>  
> -	for (i = 0; i < MAX_BPF_REG; i++)
> -		mark_ptr_or_null_reg(state, &regs[i], id, is_null);
> -
>  	for (j = 0; j <= vstate->curframe; j++) {
>  		state = vstate->frame[j];
> +		for (i = 0; i < MAX_BPF_REG; i++)
> +			mark_ptr_or_null_reg(state, &state->regs[i], id,
> +					     is_null);

Small nit: I think it would be good to follow practice from clear_all_pkt_pointers()
and release_reg_references() to move handling of a singe frame into its own function.

>  		bpf_for_each_spilled_reg(i, state, reg) {
>  			if (!reg)
>  				continue;
> 

What about semantics in other, similar functions like find_good_pkt_pointers()?
Should this also consider all frames instead?

Thanks,
Daniel
