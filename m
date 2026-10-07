Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245293F9F50
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383637; cv=pass; b=R1r4n7TJWC+JyJoJQjfD6llqJIg6ceo1r4N4oLWPlnG4Eg6ND0v2VtTUqjUzB3zMo4E9QARJP6DGNqbKhR5HReuOhQETGEvuAXvdMGNcpP1VPHMAG48j6Cm+IwMk8oZzl6q3phWbsMWjovhhGPSL2aBIm4ayRQsAhxoXBQm0MFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383637; c=relaxed/simple;
	bh=3vz4MEynY7TP1u+Mzmk7zS6TFjzCtr7smW69IrIN6qM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bdkgxOtEy8Zcqplt6eOGqh7plLupF2GsPE4Faxpe025F91NqSbERPd6oJG571Nwg3GIDa6Vdc4+yvzSP5wyhNUlbDqYTM4YSoT1auRuuSJ6vn8oavJxrciQQglpw6Z6By+O7L8SQsQGDlwCjYtouU4o19Q5RavqiA0x4rTXYHWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmImtC3u; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmImtC3u"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a772ec8389so15874781fa.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 07:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791383631; cv=none;
        d=google.com; s=arc-20260327;
        b=StaGvTcDCDQC9oCKngj4W+rWU8B7BlGshiWwXdhHv7aVAZA8N0wmCfOMU5oY5UOpJx
         PHzJBbOVP1wNv09hqUAlXsODvpLQYMBDSStX9Tu2ltNYlUHipTOwBKPCXTta0j+oH1qv
         XesJL7p77oHsu9ZXuvYjThdXg14nLAYLiyKmM0Q0K9sJW7IV8uupNKMiRTLiF8/g6yH0
         w8nDU5fZwEI19oPMSC2tlXl7qPbvuzZFrdL313QjI954rYTLy670RSASJAEV0mMAERs6
         mBXarkWOOAS2+i+ns2pvEUeC6zRePHicDuGLJmuVwxOYhuVEdcn5dlWtkeGUn2vsmGym
         wwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xEV5CyynWEcCXpBKqpG8uQ23GLYSCblWSy/rWh6fTDw=;
        fh=Wvh6tguhiE11Op+2AfFArUKDS+cg6ptOmZl7i9zY+cU=;
        b=Qg6rXlx0FqtKCwgRKYUufZ4LV8kIv8UknkM1Z5osjHqgF/U73yqc4OjS8cEuiVhvVc
         D/iVPJwCC5P2piaYTtPrt0R/kdnidG4v4gOtXHTTxtlpZHF6Dt2T4UHfekqwl9jd3csc
         wDUJoiN4uD5nAuqX5UfnkJFLS+hvIlnB+NkzusrUZd/DB9sMyl49JmOXPYJLdxhWJdlv
         S1pxAVgCmYLziqOhTPUVCSLVI2eC0evpXCRbMt4GxmP9IH5j3B1Jh1QGcre1JfX/rTXd
         ipOafp+apTTpYqdLlXPxpMRTBbNZt/2j9IdSH1EWW3EuCVvURYoRn1hUFnj/9T2WvZhl
         wWqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791383631; x=1791988431; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEV5CyynWEcCXpBKqpG8uQ23GLYSCblWSy/rWh6fTDw=;
        b=qmImtC3uzk/NU9VTkXye4HLDmUVLcSRx2S0DqWaqQax0uXKlkkNcSiJd3z7u/Kzscv
         BIvaORtyHwySim0UnEHrHMrLWZj9DOY2MOQ04Qd5LXQ/hiPfJKpYPNdFY6eL7e3s95nB
         w12fkOnV7ZFCYjdui2UEsBTUsHljxXRGTl603IZJ2dSNv8+GoV1EPb7Wqt64b1wNFKsp
         rSZnvdsUZPlmpazYoiYRdkzAenRvXojPnXZyIB8rLP7+ATf9EfKUkVlr0aOjBgV2Jiqh
         DZ3KlJy1R/nKYqrJdH8BSyj8EPnxWU/WcG9oLGLb0TDm2Zn7fQ3ADt+cbhqzxWEvebwm
         fVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791383631; x=1791988431;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xEV5CyynWEcCXpBKqpG8uQ23GLYSCblWSy/rWh6fTDw=;
        b=DIkJywjcKG3CUrY4l4p2Cmi+tNNDQt1zgRr/sZW+qR4JDgWUQpQyIz1s8xGN6J2SKO
         7d3HYDI38rVSrWdy1njUCOf/6VdbPFYZ5IVLotr7CqgLCW7a8IGI5ntXt8b8ZXMpO8+l
         5oQ549idvc2tW7AlsHQlQCM+HnD/BuYHnIts088C368FrfW41t6DOeAj17PLzU2rKgE0
         w98k0mqfldbtmTgh9d45GXuIJyH+ujZAjaygO1jXv8hRlavJ40TfwAbsFdSAj5nATBHY
         ZCZOiobfl5RRNQqejcuo2qLsZ3hhRbr0dGopYel2JbHZXx+rOAythMjJNyDV1Eigxh5n
         1M0A==
X-Gm-Message-State: AFq9FYIJqPdngXxkBCr7ioUSHEcXxuAvR0XV/O2izCpVfeXYUieNxTyZ
	Ueb6to3KtGEv55lyvRqaQZ+1ficXhzLRhGXBcb3nBajToAc5khxbeiizUBWyY01j6sl1sBR6e3h
	LOzystd6At+EXAL49lBfaGcFDlynTAOyxl71t6+8=
X-Gm-Gg: AYBFou1+c+FQYDtd/n2WNSbl4PCT6Tx1IoIB2oDBbjNWezW4kbdmMk74/Q21qv/+pjg
	cZKBn8X7y5RXxptuZWRfjdCXf6fMJboR3RD7nrzJLdTDTKW9z0MH3H59a8GORsvr4JPnH0YCMoW
	tNFZd1Jmceh26mg7QOOrZ4boJlbIQXjC+6gSo52wAZRWwcubzPuStT4IkD3zXs2EZm7vsoC8pAa
	i/PQksG7chVAq4IXjoP7GNtzEvtOhZHtwJ26cFuGpjMn4WI4WPOimCNKlWZTQUj1yN3egrvUiVf
	+KzGNtnBjgXEzKFkTkUxJKJuxtJt5H8qJe0dWFeS16OdSiSbUIRv8cHfR2kexj/zpEs=
X-Received: by 2002:a05:651c:b27:b0:3a9:7d11:a7a3 with SMTP id
 38308e7fff4ca-3a9a2c55999mr5207631fa.5.1791383630247; Wed, 07 Oct 2026
 07:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Date: Wed, 7 Oct 2026 20:33:35 +0600
X-Gm-Features: AclHuK-tMQi6q-IZo9l-pwwOzCol2tHzOi2BMj179PRCDrDdIWgS7Jc1ksfIrQE
Message-ID: <CAFj_506MtUDLP8izKqrvLhNQrzNkzcQSGBNLWjNvrCQnyWCG3g@mail.gmail.com>
Subject: [PATCH bpf] bpf: mark kfunc memory size argument precise when buffer
 is null
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

check_kfunc_args() allows a null buffer register paired with
KF_ARG_MEM_SIZE. When buff_reg is null, check_mem_size_reg() is
bypassed via break, leaving the corresponding size register at
argno un-marked for precision.

Consequently, checkpoints created along paths where a nullable buffer
is null would prune against arbitrary scalar values in the size register,
creating a state pruning asymmetry.

Mark the paired size argument precise before breaking when buff_reg
is null to ensure proper state pruning.

Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..1dcca0c737e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13191,8 +13191,12 @@ static int check_kfunc_args(struct
bpf_verifier_env *env, struct bpf_call_arg_me
  return -EINVAL;
  }

- if (bpf_register_is_null(buff_reg))
+ if (bpf_register_is_null(buff_reg)) {
+ ret = mark_arg_precision(env, argno);
+ if (ret)
+ return ret;
  break;
+ }

  ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
  BPF_READ | BPF_WRITE, true, meta, &failure);
-- 
2.55.0.windows.3
