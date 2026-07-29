Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9633CB55C
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354555; cv=pass; b=hJN5rL/U0kB63pjilO8mvVgVqKD6PGMdLbjsBduxgRltXTZvzdO+hbrBGUH5OMF97T/sr1QEeXOMmIOrkWfbeifkKFxxtPACpoB3oLTpVh54nG/RBsCa4siHah6Eaaoy08U36s7Bdqn1N+N4V83aYQcBpo6Ujwu1Vn7wmI8NJfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354555; c=relaxed/simple;
	bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVTCtExA1ZTjSrRLG6n1NkiXL3nyanziEK6OXDlQeB5y2QLaY8eQXOtbRUByxyAyP+mmS9JcxexRK3GSv8dBYgpZh2qvR61IoawrZKDslNkx8AKFZfjiaSEcsUvDhEEPcHt6u3a1lJ8e3xXdAlPVFvZA6okajsQQQYyNIYr//h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YK0H0xb1; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Ct0t1uRA; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YK0H0xb1";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Ct0t1uRA"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TJWCw63107653
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=; b=YK0H
	0xb1DPm9nCDpxbGpqgnswy4YgJeR3BrnGFAshAoVEcGsbUZp76B7dTTDLlwA336H
	r8R+amugj/dUWLx/0DXqETIwgtKrrZZ95h0j6q0abz3sZT5caDP7KVALCpee2Qr4
	uhEyVr0pc2Wvcjp9RwjNzzcGqe38ZcD/nEW+P7UiNNaxvP0Z5mDdGnhfwLu7hXc/
	NvpzLBpd5Wkrtl6Q33yxS4lpBjPRr+yvYUWHtfQpzAWJl0E2rviGI0PwFuO5AslD
	Z5O+3Zhr6qXNG24in8/OTW5yH/CzrvoePvA/wzI3D94//uPKj/wgga7iias7Zxr/
	effjiovKfg3ZLmTuVQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq6mcv9xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e92ddc199so28694497b3.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 12:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785354542; cv=none;
        d=google.com; s=arc-20260327;
        b=XTVr6ssMuODv1bMaNbwElx3KPytz6JR6yWNq93sDvWJRC/JgFboxCSre5NsFt8EF2s
         Q7nzlyKVWqO0sXeD8ZVWo2881PiTlkBcKLUbkPmWun+/cPeheB+7TDLOcHNopyujt7kC
         k3OvRB3v03yW0nRMJvz6ibwHeehdFNrTMa432V2u+va784F5f7ffZMe6mE/aX7uysSRL
         rGZ4pZiRULNC56gZjkQnIMSSVhQ4PWmrk+nN3zgUBPnBPktPnzbnREaZWMYjj0bxYK54
         BnHAfz8Zssl7Zul2ZQKlSqQAKlNIx85JJrCoNFmi5XNOFJ6HGKlVHDVzTKwLlk0SQBqj
         4n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        fh=8DfrrSiQ4REkwKcXC+BknR0uj82CdDzyBdYFHlO4hM8=;
        b=cF/ZPYpqJ1lBNp6Y6sLeyrEYMnJ2kmItB4s4WTfS+nII6sKlut8iTtTbrrPXZwpYOj
         PiPWM/cqWTBmUWiVrrfQw6eAzU/bALxiT5OzwlX33OvmG+7MTRQujQNsEAYrEOy64qua
         3qGwIsO8od/hLzj2bByAXXC/k9QPQAlB5FP9ZZZCrgJ/KjTTAbyyzSojWA1TwlBJorB7
         CIOe/MN/1PULu/bTCxvd4Q8GPMxFJml772W8vnB/Qjcx+F5yMM7Ev3J31U3YfetuIVay
         KL7vZLGDAo0Dik3AwnbIhr+SCS218EfhJtlWqK1j+7wjYsVte0bsZ0TsXEl3ExO0UMn4
         kf1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785354542; x=1785959342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=Ct0t1uRAKmNEO6pU2WZjuhEiLI6pnLsHrBXITu9Y3sLBMtCqAKrLBKserQ1xNGkp3H
         qgEE1s8+hL89s8d8/Cwrdn/tVvwD2Dmd0/lAy54ADr7VSWlOQz6l1+dp7vJGPiXk7kly
         5nKFRfVqHmi5JBIn0BOTs5QnPf8usuSlD248mYEoCDgQXrRIHpOGu62+xOk2/Vjnt2U0
         f9AHmkGsflOWZfV8FlfY4v4ROwWPVUJXrlnKYYsavAnNSjs27J2rSAqjs7l3hql4QC48
         Q7UwkRq44+bu69v2Q/QX1aVCq2c9bMD9x7rhUacD7dKH+NTZOASip+2FLwmYiCILt+ti
         fJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354542; x=1785959342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=rP0F9gR+dmyniXY1sip83hbE8CvE1/m8h1jWXlHHivLKy8qcIUhu3DRsTNNm1hgv/o
         lqfQOhsbGq4kysOdNF7qmKu2Z7LHQCE8x7eXqJ2lLAJ4OUOJggEi+CZzz4utcVxoKlay
         AZHcoM/jU+8sCUvck7ClIRH06EMxUxP+VYdVvTCs7KvbjV+5EyYnOVQ3aRmPDUrl61Rp
         VCPUeommPk9jIuoP7mv64BDn6r6JyL9psiwRJdxOVxBTq7/1Rud6MSfcD1aDLyB6Pai5
         1kYToYAwKTYwlGKonYLCswIrn3KkUw5bAPWiWpnV3rY8TOSEGQVbUe3BQADMPq1uwlZo
         +N/A==
X-Forwarded-Encrypted: i=1; AHgh+RqEYVpqY3V5by4vgHzrqB53NIJcezriJuTX8UQFr5VJgkDCloO2jQM5oCz1v5M7lBRCwFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUqnN6iG/38heh8Kzr59iTB+KwpweNm0rwdbFB4EY85ug/eqU
	9+x2IX7Om4Nchyj6fSeoPnAJAvMhkm2ru5tG62UygYVb6ycnAS/WQ62E3xUUMA7CPzPiFRtYsse
	kccgQD/SvWjnG5ZbyqEvl02EEFaR7+TyyPjQCClLlADS0ne1r5wRE/DEf+LTzafmHBvc4CxpAwz
	qDs/43RjsuRi7uqXDrIXzrhsXhxZ7z
X-Gm-Gg: AR+sD10BRbpT3vXuGuACRMHk0xnJI1z088PBNjTzdHDEoB5+wz05QjFlVrEvwfTadbC
	Xf6TdEeqwwr4lFzeDt45i9jZ9FPnU6hNaAIrWNgb6OLegIomr1oii5Q9YuxIBupCLsXq7YPALf6
	kShYVuOBHSudggMIKStHfBQMO/FvNipucjuw7nQkWptD3wuLjQQ88IDOn7
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id 00721157ae682-81fb5e5db0emr1654837b3.70.1785354542425;
        Wed, 29 Jul 2026 12:49:02 -0700 (PDT)
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id
 00721157ae682-81fb5e5db0emr1654567b3.70.1785354541887; Wed, 29 Jul 2026
 12:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home> <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
 <20260729154541.0099cb14@gandalf.local.home>
In-Reply-To: <20260729154541.0099cb14@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 15:48:50 -0400
X-Gm-Features: AUfX_mwF7DC0oGaTu80DDaK_FjjbvMjtCRB7Zz3uBteLMCWzuxKcaF0VD4WX16M
Message-ID: <CAOu3gNj=Ev+gW82_K1LFhjDWrmJ5CXGU26P6Mb8kEZrbGaMdqQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
        davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX4/s/uJvukeEA
 xT1kLx7gjxvWyoDi73eSpGBdfR0ie+Wrz7SBlCGlzQg19YLHQDS3kGI21cjYtBo8ugIY7774W6w
 v5sGA4tzB3vjnbWgLJEI0BSFhOlH9GBC9tY6PSwiQ3XgoHaPY03G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX2mC7Akv4B8Pd
 WmEjh3pYql9ggcwMVQMPsDLmWATB+YZ9VwukZ4f7y+D8/miXn7XgMwq61SuInAXRFjFDk1w7JaI
 Woraa4CbnaicgVNJqPRXZGZ75WsZdmV76oo6kD7hCWsoa9CT4vrEVlSwwwbiQsfZO3T02XnxyHQ
 3mzaRoR3ms1QCJDrnGGA8thu8gvFHOpdbfvADEh9VfWdEAmaX8MvY5PFprERrQt91O7iFolv/fC
 prqPGCs1ilz9GWCvdNkCWNVUEQMc9JkzYrFFzJ3Vhg1hLDp8Awi6n2u8Y+ujmQqg8zy/5CK6EiP
 EOAYzSDL4HZZTECWLPgr8unW2sgS4q7hrU7E/iF2Efr9Q6dy/yhRP8MOhK83y/klmQP8wPUinAw
 L11/g7OEg55O/poGQxVRLFTt+nD82pI7r4NFedEnQ4ARAafU3wHHBHasWUUa+PY4skua1ha1EsW
 t7hVBoLZT9Cd7aubrug==
X-Proofpoint-GUID: X_GqBziwJMn7Bn-hkHYPO-brKwYjQKzr
X-Authority-Analysis: v=2.4 cv=UOPt2ify c=1 sm=1 tr=0 ts=6a6a592f cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=jHs7IjXvhldTIRZNGaAA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: X_GqBziwJMn7Bn-hkHYPO-brKwYjQKzr
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290152

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 14:20:17 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Should I also clean up the entire PERMANENT flag logic we now have and
> > drop the flag itself?
>
> No, because we may need it in the unlikely case that we need to revert th=
e
> disabling of ftrace_enabled code.
>
> After so many years, we can drop that flag if nobody complains.
>
> -- Steve

Got you.
Will do.

Andrey
