Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CF1A683B
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743578; cv=none; b=S0O3Xhc5XiJKMsDyT5rfOWYyXo9KdNhmuxaNccBDVmGj3GQcto0jYUQia5UbHyCdaeqU0i/2UBkbHE2q6o/gnSYFcu60zv1u1C5kdPx2PhbdzIri84JMXOWlnl/862etDBNc82PvDDMK2KopEDkwZIoQWh4Y1Ozwt5xADYCvQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743578; c=relaxed/simple;
	bh=q8ufLpNslSSynxuiXFuLszBqCCaJfxfHaFiz4uBXhHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BduxPMOD26H12+neIyic3Wom2iFuwpSDweV3E1jiGI9k9zVNgf1WdYiK7kjX1aWFNaLa0mZcaIij5GLhRfD3f23WQZS75HZlbl7JGp5YFSEiAdXpKgty0kSSTctwTTosjbBTqxyboeWX5Ivx6tI/oOQaMztPLZVsuDK59b0sgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwSjYCxQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwSjYCxQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cbae8f69cbso863661385a.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772743576; x=1773348376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hpjhThsp+16LsJkraaDBfD6WR8AcYeiPqIr1Bw2XbvI=;
        b=GwSjYCxQHak6UYlFdWkvfoXsnMNy1DFHS1igP9KzxF5KkIBU8rrd2kem6SVsr+dpZI
         6IMlyDMsWuTY4KL3wlj96LbYW/qBrBi2FNVeo+cj2hnauqEC6XuMw6cbWcjJ+iNC7q56
         ABfVVq9mQVYXKrGlFiKJZrBz9k4M6OU+WFyotV1TqxH9bVFLoCqG9A8CCFJOeLWdNSCL
         qYAaHQDkoSfr4r/QX9Ns00ER0HOWay7qG4Pt+wIdPtCpzudnPxl2VwF1TZNvwkpO3tiV
         ACJZBEV8kYzKxsIwkCuV1y4hh7WizC9JGw39yPJNMpClzltGTMtscsqlcysJiya8Jx13
         F5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743576; x=1773348376;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpjhThsp+16LsJkraaDBfD6WR8AcYeiPqIr1Bw2XbvI=;
        b=XlGzXvuvRYmuLGrQw58CwU0mLGFB1FPZcKKv5+HpRLBAz9ISnS5NH7I+1lZag8EhHf
         fRALIPgE2/+BQMHtZygpYyFiX3j/hkfxlTFNDYkxPAVIQ0kni+qToyMR+xyhDGYCD5nZ
         w5hRldTJQyNCOZXSCCTHVFYB3ehChl8glc//YAws6tJTDUJUWCaXRkyQNZPPPL1wEHhj
         3v14P1vVUZszz4DjsXBBUyD0RbqOsRcFD5iJ4DG1LzYNzDG6ktNx8cZZJ1RO42HYl8VF
         Gnu6ukIjQLkIuqkNfJmhko+9cYrvrnI8SLPZigl/2EPCKmlPCvo0yFEdUaHK+0/Yt37p
         oTFg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3e+Em8jmEPsU1YgKg1U2Tme+TZWEUpWKsgtzSp+M/tze5sSTyRn5ZeAD1Y2r0N24kEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI80EzZ0MQTeZ9GdGttV8H5XkcMSpNVrUZgzcZruGcOVtkYnXH
	b3fbfyP3pbfR5pw+vu5U41K7cq4Obx1GC510JMxCuEr27mYWNxbEYdNX
X-Gm-Gg: ATEYQzwwpXz68kVdfI+bFljBImElOYxTxi8CREZ4J0uW8faCqyF3wRGFqxQXkkUYu/B
	ROjPjHJL7AZqhgfhYVqCvjd3dZSyKSF5yEApLlBAru9239jm2y8a6OaVr1VRRdh/xiBVQC4sXhE
	4YDGF4IfRR3W4zn9MF7csi4Glq63EBbvdom2p6vY6+hbNjETv9rIDTavxbhkrNJNBbWgdVKGGGQ
	x+7kRjN8A9kk1LyLJgSH8o+hj0LDfVX6ucOMqamyE4EYCCTyLknQt3bINo6ocYPJR8IN0geHWU9
	cbkWbIK+CZYsLExw9Pc9Z2qL8vQ0wCjFY/aMelM+ISD7xviBPnZzvOKp9lUYC8P7dTxt3iGgnnq
	HsH4jif23yoxxDG12bU/ozOSYnKPTP+0H8WpeDt8LaxEpEawpQEB7qfueUeFlYJEvNm3tConsT4
	GQveXUuGFbQMIl6NOAorahsoeEXbIsbdX2SZGhw9c8PxAvKrH0knYV
X-Received: by 2002:a05:620a:4014:b0:8cb:3919:f538 with SMTP id af79cd13be357-8cd634f1ccfmr407076785a.39.1772743576065;
        Thu, 05 Mar 2026 12:46:16 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf658f70sm1936984085a.7.2026.03.05.12.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:46:15 -0800 (PST)
Message-ID: <3fd3c01483348c678490810e379ceb76ceab7781.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Thu, 05 Mar 2026 12:46:11 -0800
In-Reply-To: <DGV3PH3KCD9F.T400P92JF2T5@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
	 <20260303043106.406099-2-emil@etsalapatis.com>
	 <592a6eacf7c278137e49acb62f527e07a6c0b473.camel@gmail.com>
	 <DGV3PH3KCD9F.T400P92JF2T5@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 14:38 -0500, Emil Tsalapatis wrote:

[...]

> > > @@ -6723,8 +6728,8 @@ static int check_max_stack_depth_subprog(struct=
 bpf_verifier_env *env, int idx,
> > >  				continue;
> > >  			if (subprog[idx].is_cb)
> > >  				err =3D true;
> >=20
> > Below the old version of the loop does not include current frame, but
> > the new version *does* include current frame. Looks like the above
> > check can be removed.
> >=20
>=20
> Makes sense.
>=20
> > > -			for (int c =3D 0; c < frame && !err; c++) {
> > > -				if (subprog[ret_prog[c]].is_cb) {
> > > +			for (tmp =3D idx; tmp >=3D 0 && !err; tmp =3D subprog[tmp].cidx) =
{
> > > +				if (subprog[tmp].is_cb) {
> > >  					err =3D true;
> > >  					break;
> > >  				}
> >=20
> > This code checks that bpf_throw() cannot be called from callbacks.
> > The `is_cb` is set in push_callback_call() both for sync and async
> > callbacks, it is also set for exception callback separately.
> > Meaning that check_return_code() can be simplified further.
> >=20
>=20
> Do you mean we can simplify the check for choosing between
> check_return_code and check_global_subprog_return_code to just check
> is_cb instead of checking both is_async_cb and is_exception_cb?

Actually, I was thinking about `frame->in_async_callback_fn` checks in
check_return_code(). But on a second thought these are unrelated.
Please skip my comment above.

[...]

> > > @@ -6783,12 +6792,12 @@ static int check_max_stack_depth_subprog(stru=
ct bpf_verifier_env *env, int idx,
> > >  	 * tail call counter throughout bpf2bpf calls combined with tailcal=
ls
> > >  	 */
> > >  	if (tail_call_reachable)
> >=20
> > Unrelated to current patch, but looks like an issue.
> > `tail_call_reachable` is not reset anywhere in
> > check_max_stack_depth_subprog(). Once it flips to true all calls
> > visited afterwards trigger spine to be marked.
> >=20
>=20
> You're right, this is never unset. I can send a followup patchset for
> this along with the followups for the check_return_code patch. I believe
> we can change this to eagerly set the subprog's tail_call_reachable flag
> directly instead of using a stack variable.=20
>=20
> > > -		for (j =3D 0; j < frame; j++) {
> > > -			if (subprog[ret_prog[j]].is_exception_cb) {
> > > +		for (tmp =3D idx; tmp >=3D 0; tmp =3D subprog[tmp].cidx) {
> > > +			if (subprog[tmp].is_exception_cb) {
> >=20
> > As with previous such loop, the new code seem to include current frame.
> > Does this change anything?
> >=20
>=20
> I think it is ok, though since as you pointed out tail_call_reachable doe=
sn't=20
> currently seem to work correctly I can only assume: We set tail_call_reac=
hable=20
> if any of the subprogs called by the current one make a tail call. If
> that's the case, the current frame should also count as tail_call_reachab=
le.
>=20
> It all depends on where tail_call_reachable is supposed to be set and uns=
et. I=20
> think it's supposed to flow from callee to caller, and if that's the
> case we should hoist up the whole loop to where we initially set the
> stack variable.

So, the tail_call_reachable flag is transferred to subprog[*].tail_call_rea=
chable
property. In check_subprogs() there is direct `subprog[cur_subprog].tail_ca=
ll_reachable =3D true`
if tail call exists in the subprogram. Looks like behavior does not really =
change
with this patch.

> > >  				verbose(env, "cannot tail call within exception cb\n");
> > >  				return -EINVAL;
> > >  			}
> > > -			subprog[ret_prog[j]].tail_call_reachable =3D true;
> > > +			subprog[tmp].tail_call_reachable =3D true;
> > >  		}
> > >  	if (subprog[0].tail_call_reachable)
> > >  		env->prog->aux->tail_call_reachable =3D true;

[...]
