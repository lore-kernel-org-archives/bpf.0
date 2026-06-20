Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078D21ABC9
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781926075; cv=none; b=EDtRt1w2Y0dhc/yWW0ssmFaPkdq3hXPg/jzibt6zSgCIkXZa3TAsuwtZXLKKRkDpRB0DuaMuaykUxjPZ3B5N8Iji8bPn2fsmfZy7YQm1dZqgqABJHUwmyATo8BQc9BHacwpLMcWWCvSk0vYoagYDa8VHis1uaavnhPMLkLYBbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781926075; c=relaxed/simple;
	bh=8+IqhYsmbBGClBl1Opw3cYjz1bT4b9L2+OvSn38h03A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qyfqpbFTGkImGLrCzAyPCWlngA+YP6G0MwgVR4BcfAof2jrgZwDROTb6yirV5YLV9cv8HunatgIcnFrrMsdfxi7CRkbMOcH5/4rB5sIQ09WrImN7i+0gKoJLnknHBVc9JXX4H98eRYlJVoFF4YAXGE0XVkw/O7BkljahkrpKia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qb0aQTYF; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qb0aQTYF"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69e1eba21a6so2312367eaf.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781926073; x=1782530873; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/1/Mg7emQaBENUuGSJ+5NebjL57uLeYV751FIXQTYs=;
        b=qb0aQTYF8FeU1fICr0TrlN2r1sYnGeaQQbh79UuETf4gAfq+bJQXNiEIFRMxLsm0yk
         V4MLxFEdQ5P2SMmI+cmW/c5QNYq683FQfPde8BsHID1+/5t5MTMRAxj9I+RvO2nVrY3Z
         gw4YrA7p1ySx7HfctJ+S9TGIZZPPyP8HhHrf4gK6JLcYN/e+Lm6ayjtgq/4u5sCBv5zA
         4Rv3BRSxjSCJZV25nS8UnyfQUiaygSKMJ32KocLGzKMaxSEOUILjyXeylKRAkxSLaJfW
         /hTthXLantFORKTv8F/A8K1SfRNkn3yJrM70jkWoaXU2HCBn2Chb53nvYmFf1arstM7z
         Rt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781926073; x=1782530873;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/1/Mg7emQaBENUuGSJ+5NebjL57uLeYV751FIXQTYs=;
        b=KVrGFh+fTIeZqOuj1ii1iJ68QLuq7C/FmioCyOUE8IK2JOtzwDeqQfxRSG4G86yfo2
         kpyiFQ2dWEPDuf/Fzuv9Y8XX++Ql/fT8WjeGtquz3Pvm98LZIfqBimZNiIK/VPSiWume
         Il5bb9mFkY4jrfmsE3L4d7NKJ+QIu/Lsnqh6fFJ8ax5b885bthbeCw5cFf4RGYppXyao
         iFAha/m+n/dhXHf5TC38WJO+sYfTba2Tyv/LHuquMnQcKS87ii/z7rJfBzqpzYBfXuOR
         FDZ3k6NzcfQe/BuR+42OMQGo6HDBYb0OPzwuveIzcw7swBxbBS5oDng9bKlS4BxNtKul
         yrhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NGa2Rg7zHLLJs2YFhbdeaH/J4cBx3HmKGqwbfPVcUxDpBYJU8lrgYQ/+TpywijTRsNus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgXW/kzgqTdvopgtlHF8JuP41/+lIeNlVUo2kHoBYP2xGxQNn
	cDgJXSJl1+UszqsLsv2E47NrPra0mOPIRf8czRXJkFD8AEqWJF6qKe4o
X-Gm-Gg: AfdE7ck5Qm9BG8uOahvWms/iWkz1Fs0Z2GFSzugchw2jFtdXdKx2YHnSD9FwmlzpQEA
	54BgiUpEUJqgs7Hs3TvmybQkjHer3Epw/Qhpsc2BLG7edzAZqN3xeNHjwGx2O/8wP8vZjx1o3zA
	+6+iK70xEHdaNx2GvX3F4p0zfTdSKRmRqvrNf796ztZZmRrP7rAa6knlbFTBOBcp89QQbJTz1DN
	wiFTDeLJeZ2m88lQMPE13pEba9sRzhQhaSqiEnT9HGx9uOZig97HqWOIZXmcgpqKZtCUn640UD4
	IE+twf680zQOLYVIdVryZQ5+rW7MUcQN9aLBapIcckDeylVSYWmrIChH3giea5+NOHm8P3r65bW
	u20ip1Kxh0bPKB93cUPcbBUNifq/R5ULDnt6N0pdtapvNiF87aoKI2i+X9+LIdmJIMH7XHVeidk
	oXfC48Sp0g5Y4hsDtVq3LtVNXGNG5fF7OB93TYAV1bdPNVy6HFam34JM95B+x6Mi+B0eI+pp1L/
	ruBmOX+UDYY8KRIqw==
X-Received: by 2002:a05:6820:189a:b0:696:573c:9f0b with SMTP id 006d021491bc7-6a0d8da24d7mr4814286eaf.14.1781926072536;
        Fri, 19 Jun 2026 20:27:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ecd3de2sm1275554fac.8.2026.06.19.20.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 20:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 20:27:50 -0700
Message-Id: <DJDK2NVO8903.19LWKQ3ST3U89@gmail.com>
Cc: "JP Kobryn" <jp.kobryn@linux.dev>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "linux-mm" <linux-mm@kvack.org>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Roman Gushchin" <roman.gushchin@linux.dev>
X-Mailer: aerc
References: <20260617202147.78347-1-jp.kobryn@linux.dev>
 <CAADnVQJ=q7hJkt=ekLD_a5KjJ_+icdwgsY61rujjLMKAKByvWw@mail.gmail.com>
 <7ia4cxxosss5.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4cxxosss5.fsf@castle.c.googlers.com>

On Wed Jun 17, 2026 at 3:31 PM PDT, Roman Gushchin wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> On Wed, Jun 17, 2026 at 1:22=E2=80=AFPM JP Kobryn <jp.kobryn@linux.dev> =
wrote:
>>>
>>> The kfuncs in bpf_memcontrol.c are not called by in-kernel C code. They=
 are
>>> only referenced by BPF programs and resolved through BTF.
>>>
>>> Since no external linkage is needed, mark these functions static.
>>>
>>> Fixes: 5904db9891f8 ("mm: introduce BPF kfuncs to deal with memcg point=
ers")
>>> Fixes: 5c7db3239c9f ("mm: introduce bpf_get_root_mem_cgroup() BPF kfunc=
")
>>> Fixes: 99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statisti=
cs and events")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp=
@intel.com/
>>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
>>> ---
>>>  mm/bpf_memcontrol.c | 21 +++++++++++----------
>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>>> index 716df49d7647..eff79bb2c758 100644
>>> --- a/mm/bpf_memcontrol.c
>>> +++ b/mm/bpf_memcontrol.c
>>> @@ -20,7 +20,7 @@ __bpf_kfunc_start_defs();
>>>   *
>>>   * Return: A pointer to the root memory cgroup.
>>>   */
>>> -__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>>> +__bpf_kfunc static struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>>
>> sashiko disappoints. It couldn't notice that kfuncs should not be static=
.
>> We have few "__bpf_kfunc static" in net/ipv4/
>> that work by sort-of "luck", since their addresses are taken.
>>
>> In general kfuncs cannot be declared static.
>
> It seems like it thought hard on it but failed based on the existing
> code and a bit vague documentation in Documentation/bpf/kfuncs.rst:
>
>   kfunc definitions should also always be annotated with the ``__bpf_kfun=
c``
>   macro. This prevents issues such as the compiler inlining the kfunc if =
it's a
>   static kernel function, or the function ...
>
> So it reads like bpf kfuncs can be static.
>
> This is the reasoning from the logs (a dismissed concern, to be precise):
> {
>       "type": "Dead Code / Linker Error",
>
>       "description": "Marking kfuncs as static could cause the compiler
>       to optimize them away, breaking BPF verifier BTF resolution.",
>
>       "reasoning": "The patch adds `static` to multiple `__bpf_kfunc`
>       annotated functions that are not called anywhere in C
>       code. Normally, a compiler would remove unused static functions or
>       fail to expose them in object files, which could prevent the BTF
>       ID generation logic (`resolve_btfids`) from finding them. However,
>       the `__bpf_kfunc` macro expands to include `__used` and
>       `__retain`, which strictly instructs the compiler and linker to
>       preserve the functions in the object file regardless of
>       usage. Additionally, `resolve_btfids` and `BTF_ID_FLAGS`
>       successfully parse and resolve `STB_LOCAL` static symbols, making
>       this change completely safe and correct.",

Almost, except it's not clear what takes priority for the compiler.
__bpf_kfunc used to have '__used' and it was enough until clang
got too aggressive in LTO mode. So we added '__retain' and so far
it seems to be holding, but sashiko is missing that both of these
attributes don't say anything about _name_ of the function.
'static' keyword means that compiler is free to rename it and
compilers do take advantage of that from time to time,
while __used and __retain don't add 'do-not-rename' restriction
to the compiler.

Also look at it from the other angle.. why anyone would add
'static' when the function is clearly not static to this particular
compilation unit. It will be used outside of it by bpf progs
that are obviuosly not part of this .c file.

Documentation/bpf/kfuncs.rst needs to be updated.

JP,
pls send a patch to update the docs and include few words
to ignore sparse.

