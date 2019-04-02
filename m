Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53229C10F0B
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC672146E
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfDBOhX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:37:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:52844 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDBOhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 10:37:22 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBKXQ-00056A-Jn; Tue, 02 Apr 2019 16:37:20 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBKXQ-0001tZ-7t; Tue, 02 Apr 2019 16:37:20 +0200
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
To:     Paul Chaignon <paul.chaignon@orange.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20190402115811.GA6303@Nover>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
Date:   Tue, 2 Apr 2019 16:37:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190402115811.GA6303@Nover>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25407/Tue Apr  2 09:54:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02/2019 01:58 PM, Paul Chaignon wrote:
> Three checks for verifier bugs were introduced in commit f4d7e40 ("bpf:
> introduce function calls (verification)").  The bugs were reported as
> incorrect programs instead of kernel warnings as the present patch
> implements.
> 
> Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>

Thanks for the patch, I think these WARN_ONCE() are a bit out of context though,
meaning it lacks additional information about the program in kernel log once we
actually manage to trigger it which we'd otherwise would potentially have had with
the verbose() log. And from a program debugging pov, it makes it harder after this
patch when verification log would suggest that all is fine. Looks like we already
have a few WARN_ONCE() in verifier, they should probably be converted to verbose()
as well to be consistent. If we really want to have a kernel warn, then lets add a
helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
the verbose log intact as well.

> ---
>  kernel/bpf/verifier.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 87221fda1321..12499e72b0d5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1145,9 +1145,9 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  		if (writes && state->live & REG_LIVE_WRITTEN)
>  			break;
>  		if (parent->live & REG_LIVE_DONE) {
> -			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
> -				reg_type_str[parent->type],
> -				parent->var_off.value, parent->off);
> +			WARN_ONCE(1, "verifier bug type %s var_off %lld off %d\n",
> +				  reg_type_str[parent->type],
> +				  parent->var_off.value, parent->off);
>  			return -EFAULT;
>  		}
>  		/* ... then we depend on parent's value */
> @@ -2888,15 +2888,15 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	target_insn = *insn_idx + insn->imm;
>  	subprog = find_subprog(env, target_insn + 1);
>  	if (subprog < 0) {
> -		verbose(env, "verifier bug. No program starts at insn %d\n",
> -			target_insn + 1);
> +		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
> +			  target_insn + 1);
>  		return -EFAULT;
>  	}
>  
>  	caller = state->frame[state->curframe];
>  	if (state->frame[state->curframe + 1]) {
> -		verbose(env, "verifier bug. Frame %d already allocated\n",
> -			state->curframe + 1);
> +		WARN_ONCE(1, "verifier bug. Frame %d already allocated\n",
> +			  state->curframe + 1);
>  		return -EFAULT;
>  	}
>  
> 

