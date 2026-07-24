Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D241CB5C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887371; cv=pass; b=sHDJ2/54goWzKGmb9GEV6t2S7Q34wD+NNvErbJBYh/N5Vkbru7g1dObQdMm7b9emBQxhE1T3/E10iQxmBGm4VwUDe6K6t/yz0TpvsnrK5suCdt1zyODF8sEopjulTiWDXLej29g/OSYO7rvBpvL1PAiH/Atp3J6pW2QREkuEklc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887371; c=relaxed/simple;
	bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGiz595RUZhv0kUY1nrp0qGHRCUoPl/1CllrjsVAZeTnVpbotYfgF1Q3RCDTn14bwDK6kVIKKqfYafixqIYwMNtnzOLfqRMXVPe0uLwY22SZE5fvWRJm/bL8og6FeXf4Fs06T3uNy9S/UskrLRNqi+yYAoFox5JSxLUDMFcpzpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie9j1sjQ; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie9j1sjQ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so34590a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784887367; cv=none;
        d=google.com; s=arc-20260327;
        b=rHkS8i/+XgQa8J+H8hMzI3RR5YVU643CR5NAML+a1R4T6wONWoe1Nnr6Ow3MwsFTlx
         RfzLlQziV9vOmqkFZ0NblFhGQExOpqgoRPeFWct4GX2GA5hnbmtnD1235WYwS7cyXj87
         GKvPVCX8MjNCW9uf60bI3FoP0ZdPD79zEg6oXj5OcZRJLwDTi1KEg/9CKIaYovkErfZQ
         AA3ypxE8tQAzjjt+xSAe3RL8BO7BcaC3oYFjYJlyGm60CqKNzk410fMYm9CqyhEJx85i
         Ag91BuVTRQBtvwAwoaXdlRqI18akZJRqu5N5GHT0kUPQSRD7CJX0w4oUrrBecuUGpbyu
         UWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        fh=A4WoJbnApddz7BKCWUgsCXMFQXkTbtaCkFu0f/GAAw8=;
        b=r7gfrojUJnb5EkCsCzg7vigAge1a1pAqMxpLjZIkdbWoEeGaU+WZ7/nmBl6DF1vu+5
         LckRiWy7jPPFPBWtg+PYbF2wTrU29kqzircFmz5dXnmUDPDqUkD8MHHst/KBIP9Z1koO
         n5J2+TaIR9GwaZbi7xt2kKPruQYFH2WEBJMxbzqqRCAHkDht1z+G6DsQzSwZVEVkDSgW
         tZZ8ZmgBLF/LqGQG/5Czw98FKpJCY1IWSvavAU+gNxFZY+zPGW5d3dVl6IId1+o03vfH
         kzAWC94Du7O7GFz/mUUkYEyuQV33oRSJDp7BfANglloKKU0hEsOiW6q2rXeT/ot/jRI2
         H9BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784887367; x=1785492167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=ie9j1sjQXi6oO16pWAfr3yBFSJQx7smD72iWnrR6HuFhZezierdTz9lEWSNQ7hWyrP
         I5XOYGDz+PvTRquSJzh+J2J385R6Wy16WXQsYcB7nw+ra0UWCd5gOsQWVG9BsNau47kX
         gQkc085nqcD/4p2mjjLf0GzWsW8H+PYpoBK6OUhP5ire1rHzVMabp4/H7GXTmYXTnvvC
         3vD+M+lJON47R3LggGp7RVcjyE++7qTwX3DaMATuOSeFj8tfs/h4LUxA3habHSdHjKIz
         CN0n9EX5mUUqSb7pGuvw7+/ZLzFfEzS6E3ku2ElbpDH1B1547K1ephUeXIxsXLsZzmMz
         GV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887367; x=1785492167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUL3i+XJlKERnsF8FzYTlTsyXlOwS7+NYYyYGSxwR7U=;
        b=Kpe+J7M5CkpE0e0IH02WduhijvhZVMaVcKRKlSyrBm8NF656cESNAWAyP6KKYjI99I
         JMPULVrmKCDTiRBrbOteaA3cdTtSGEAsbYsb53eArgUO4R/YThKjZUh1yFblWvQHgQzL
         u1ImMcgqNABNRbkVnWLMjTG/WxFxPe0E6uYCB1c57mdYPigos7N2ga66CAGz+UynXO5y
         grCsEgG/cyzwjg7AIZqGJPFHImbj0+yep9juBNtYAPn3E5b0xCXzvSFeX+NY8wp+OyhK
         AfFwOpfpX0ApBO5yvuFmTIwrUYbaJunOGwZMioI9KrxH93U5EMXj7QLGigVlfmf7RQlm
         NKXA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnn7b0jVp0c+rrII1ksvrSgGi2rZ0czTGnYE3SZ2q+AQ1UscbY2ed0lQ8/CxH4ydz+RbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55tc2g7JUk5EiAKs0u6oQZ4XKx1C0AugioiTHjIK7UmJpj1fd
	FU/2kQJu5958u9fNIXa/PCeH5Evhshruvf0+OlaL/Zcp+NGw+rPUQSlTUwzRN+Q1oEasV8UUIZa
	rbWsuPcFnFFOm7F1ise9SKeK5fqfro2g=
X-Gm-Gg: AR+sD119dyvExn2KUM9kyoSU1240NT3XIYqYZBlgkoHIbyKD/VT/289tvcJKeiAexVr
	ZPWMVy70m4qXl1zlV3lWnI7EhQ0oDiplkGm1xMuXtyixFa/FwZh17Mh9qpo+PO+Lyd7ZUUY1YG9
	7zT2ZD3CMjPI+ZOEdS64zGhFes8jKBs1SGeDralYoi5ALpdbGuIOjyxud72kitDBtEr0e9qRF/b
	7Sx4BCdJJTU4mlt8n8T+F4Z33ZwVUzmTrVkeTF9nTv9ZTIZ7nOSs2cpTfwf1U360amQTHzZ7sH2
	O5UFV0RvE2/N9No=
X-Received: by 2002:a05:6402:3997:b0:69c:7a3f:9fb5 with SMTP id
 4fb4d7f45d1cf-69f8ddfa863mr771337a12.7.1784887366457; Fri, 24 Jul 2026
 03:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com>
In-Reply-To: <87ldb0lo8t.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:02:33 +0800
X-Gm-Features: AUfX_mxJN7h4yxh_VHEGxVwUbDqmPuLUq7be4uNYXJEjMRhF3AJnYtdiUAsj4Rs
Message-ID: <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 5:40=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 23, 2026 at 10:00 AM -07, Jakub Kicinski wrote:
> > On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
> >> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendms=
g()
> >
> > Since you are spamming the list with the reposts of this could you
> > please add [PATCH bpf] to the subject so that netdev CI is not confused
> > into caring?
>
> +1 because we need bpf CI to run sockmap selftests on this patch.
> Please point your agent at Documentation/bpf/bpf_devel_QA.rst.
>
> Contrary to Emil's ask, I'd recommend fixing one issue at a time.
> Reviewing multiple fixes crammed into one patch is harder, IMO.

Sorry for the disturbance. I was trying to fix the other issues
reported by sashiko,
but it seems it is harder to fix multiple bugs in one patch despite
being the same
function, as more issues are flagged by sashiko when a new patch is sent...

Then please just take the original v1 patch for reference and ignore v2 and=
 v3,
and I will stop sending new patches for this report until there is
further patch review.
If there is a new patch, [PATCH bpf] will be used properly.

Best, Chengfeng
